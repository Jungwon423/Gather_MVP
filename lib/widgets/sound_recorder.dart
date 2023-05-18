import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:audio_session/audio_session.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

import 'package:http/http.dart' as http;

import '../../../API_KEYS.dart';

class SoundRecorder {
  FlutterSoundRecorder? recorder;
  bool recorderInit = false;

  bool? get isRecording => recorder?.isRecording;

  Future init() async {
    recorder = FlutterSoundRecorder();

    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission not granted');
    }

    if (Platform.isIOS) {
      final session = await AudioSession.instance;
      await session.configure(AudioSessionConfiguration(
        avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
        avAudioSessionCategoryOptions:
            AVAudioSessionCategoryOptions.allowBluetooth |
                AVAudioSessionCategoryOptions.defaultToSpeaker,
        avAudioSessionMode: AVAudioSessionMode.spokenAudio,
        avAudioSessionRouteSharingPolicy:
            AVAudioSessionRouteSharingPolicy.defaultPolicy,
        avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
        androidAudioAttributes: const AndroidAudioAttributes(
          contentType: AndroidAudioContentType.speech,
          flags: AndroidAudioFlags.none,
          usage: AndroidAudioUsage.voiceCommunication,
        ),
        androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
        androidWillPauseWhenDucked: true,
      ));

      await recorder!.openRecorder();
      recorderInit = true;
    }

    await recorder!.openRecorder();
    recorderInit = true;
  }

  void dispose() {
    if (!recorderInit) return;

    recorder!.closeRecorder();
    recorder = null;
    recorderInit = false;
  }

  Future record() async {
    if (!recorderInit) return;
    Directory tempDir = await getTemporaryDirectory();
    await recorder!.startRecorder(toFile: '${tempDir.path}/my_recording.mp4');
  }

  Future stop() async {
    if (!recorderInit) return 'error';
    if (!recorder!.isRecording) return 'recorder not playing';

    await recorder!.stopRecorder();
  }

  Future<String> transcribe(String prompt) async {
    Directory tempDir = await getTemporaryDirectory();
    String transcribe =
        await sendToWhisperAPI('${tempDir.path}/my_recording.mp4', prompt);

    return transcribe;
  }

  Future toggleRecording() async {
    if (recorder!.isStopped) {
      await record();
    } else {
      await stop();
    }
  }

  Future<String> sendToWhisperAPI(String filePath, String prompt) async {
    int random = Random().nextInt(3);
    String apiKey = apiKeyList[random];
    String apiUrl = 'https://api.openai.com/v1/audio/translations';

    // Read the audio file into memory as bytes
    List<int> audioBytes = await File(filePath).readAsBytes();

    // Get the mime type for the MP4 file
    String? mimeType = lookupMimeType(filePath);

    // Create a multipart request
    http.MultipartRequest request =
        http.MultipartRequest('POST', Uri.parse(apiUrl));

    // Add headers
    request.headers.addAll({
      'Authorization': 'Bearer $apiKey',
    });

    // Attach the MP4 file
    request.files.add(
      http.MultipartFile.fromBytes(
        'file',
        audioBytes,
        filename: 'openai.mp4',
        contentType: MediaType.parse(mimeType!),
      ),
    );

    // Add the model parameter
    request.fields['model'] = 'whisper-1';
    request.fields['temperature'] = '0';
    request.fields['prompt'] = prompt;
    request.fields['language'] = 'en';

    // Send the request and get the response
    http.StreamedResponse response = await request.send();

    // Parse the response
    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      Map<String, dynamic> jsonResponse = jsonDecode(responseBody);

      print(responseBody);

      return jsonResponse['text'];
    } else {
      print('Failed to send video to Whisper API: ${response.statusCode}');
      return 'error';
    }
  }
}
