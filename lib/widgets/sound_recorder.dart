import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:microphone/microphone.dart';

import 'package:http/http.dart' as http;

import '../../../API_KEYS.dart';
import 'dart:html' as html;

class SoundRecorder {
  MicrophoneRecorder? microphoneRecorder;

  bool recorderInit = false;

  bool isRecording = false;

  Uint8List? bytes;

  Future init() async {
    await html.window.navigator.getUserMedia(audio: true, video: true);


    recorderInit = true;
  }

  void dispose() {
    if (!recorderInit) return;

    microphoneRecorder!.dispose();
    microphoneRecorder = null;
    recorderInit = false;
  }

  Future record() async {
    print('record 함수 진입');
    print('microphoneRecorder 객체 생성');
    try {
      // microphoneRecorder?.dispose();
      microphoneRecorder = MicrophoneRecorder();
      await microphoneRecorder!.init();
      print(microphoneRecorder==null);
    }
    catch(e) {
      print('에러 발생 :!!!');
      print(e);
      print('위는 에러 코드');
    }

    print('record init 완료');

    if (!recorderInit) return;
    isRecording = true;
    microphoneRecorder!.start();

    print('record start!');
  }

  Future stop() async {
    if (!recorderInit) return 'error';
    isRecording = false;
    await microphoneRecorder!.stop();

    bytes = await microphoneRecorder!.toBytes();
    microphoneRecorder!.dispose();
  }

  Future<String> transcribe(String prompt) async {
    String transcribe = await sendToWhisperAPI(prompt);

    return transcribe;
  }

  Future<String> sendToWhisperAPI(String prompt) async {
    int random = Random().nextInt(3);
    String apiKey = apiKeyList[random];
    String apiUrl = 'https://api.openai.com/v1/audio/translations';

    if (bytes == null) {
      return 'bytes is null';
    }

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
        bytes!.toList(),
        filename: 'openai.mp4'

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
      return jsonResponse['text'];
    } else {
      print('Failed to send video to Whisper API: ${response.statusCode}');
      return 'error';
    }
  }
}
