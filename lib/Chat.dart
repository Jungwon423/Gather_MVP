import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:gather_mvp/theme.dart';
import 'package:gather_mvp/widgets/finish_dialog.dart';
import 'package:gather_mvp/widgets/messages_in_chat.dart';
import 'package:gather_mvp/widgets/sound_recorder.dart';
import 'package:googleapis/texttospeech/v1.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'Google_API_Credentials.dart';
import 'Provider/provider_chat.dart';
import 'models/chat_in_chat.dart';


class NewChatScreen extends StatefulWidget {
  const NewChatScreen({super.key});

  @override
  State<NewChatScreen> createState() => _NewChatScreenState();
}

class _NewChatScreenState extends State<NewChatScreen> {
  final recorder = SoundRecorder();

  int voiceIndex = 0;

  bool canSpeak = false;

  String chatId = '';

  List<ChatInChat> chatList = [];

  late AutoRefreshingAuthClient client;

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    chatId = context.read<ProviderChat>().chatId;
    chatList.add(ChatInChat(DateTime.now(),
        context.read<ProviderChat>().initialChat, 'GPT', false, [''], true));

    getRecommend(0);

    initAPI().then(
            (value) => speak(context.read<ProviderChat>().initialChat).then((_) => {
          recorder.init().then((value) => {
            setState(() {
              canSpeak = true;
            })
          })
        }));
  }

  Future<void> initAPI() async {
    client = await clientViaServiceAccount(
        credentials, ['https://www.googleapis.com/auth/cloud-platform']);
  }

  @override
  void dispose() {
    recorder.dispose();
    super.dispose();
  }

  // 녹음 종료 버튼 누름
  void transcribe(String prompt) async {
    await recorder.stop();
    setState(() {
      canSpeak = false;
    });

    // WaitingChatBubble 추가
    chatList.add(ChatInChat(DateTime.now(), "", 'me', true, [''], false));
    setState(() {});

    // 내가 말한 걸 whisper로 text 변환
    String transcribe = await recorder.transcribe(prompt);


    if (transcribe != 'error' && transcribe != 'recorder not playing') {
      setState(() {});

      chatList.removeLast();
      chatList
          .add(ChatInChat(DateTime.now(), transcribe, 'me', false, [''], true));
      setState(() {});

      // 1. BE에서 text를 document에 삽입할 수 있도록 보내준다
      await sendToBE(transcribe);

      // 2. BE에 whisper transcribe 된 것에 대한 tip 요청
      if (chatList.length % 2 == 0) {
        getShortTip(chatList.length - 1);
        getTip(chatList.length - 1);
      }

      // WaitingChatBubble 추가
      chatList.add(ChatInChat(DateTime.now(), "", 'waiting', true, [''], true));
      setState(() {});

      // 3. BE에 text를 보내서 각각 tip과 GPT의 대답을 얻어낸다.
      askGPT(transcribe);
    }
  }

  Future getShortTip(int index) async {
    String uri = 'http://101.101.209.54:80/chat/shortTip';
    // String uri = 'http://43.201.21.32:80/chat/shortTip';

    http.Response response = await http.post(Uri.parse(uri),
        headers: <String, String>{'Content-Type': "application/json"},
        body: jsonEncode(<String, dynamic>{
          'idx': index,
          'chat_id': chatId,
        }));

    String responseBody = utf8.decode(response.bodyBytes);
    Map<String, dynamic> responseMap = json.decode(responseBody);
    int idx = responseMap['idx'];
    bool ok = responseMap['tip_ok'];
    double credit = responseMap['credit'];
    if (!mounted) return;

    if (ok) {
      String tipSentence = responseMap['tip_sentence'];
      String tipExplain = '';
      ChatInChat chatInChat = chatList[idx];
      chatInChat.helpText = [tipSentence, tipExplain];

      chatList[idx] = chatInChat;

      setState(() {});


      String uri2 = 'http://101.101.209.54:80/chat/translate';
      // String uri2 = 'http://43.201.21.32:80/chat/translate';

      // 번역 요청 API
      http.Response response = await http.post(Uri.parse(uri2),
          headers: <String, String>{'Content-Type': "application/json"},
          body: jsonEncode(<String, dynamic>{
            'idx': index,
            'chat_id': chatId,
          }));

      String responseBody2 = utf8.decode(response.bodyBytes);
      Map<String, dynamic> responseMap2 = json.decode(responseBody2);
      int idx2 = responseMap2['idx'];
      String result = responseMap2['result'];
      // double credit2 = responseMap['credit'];

      ChatInChat chatInChat2 = chatList[idx2];
      List<String> helpText = chatInChat2.helpText;
      helpText[1] = result;
      chatInChat2.helpText = helpText;
      chatList[idx2] = chatInChat2;

      setState(() {});
    } else {
      ChatInChat chatInChat = chatList[idx];
      chatInChat.helpText = ['AI 선생님이 고민하다 쓰려졌어요 🙃'];
    }
  }

  Future getTip(int index) async {
    String uri = 'http://101.101.209.54:80/chat/tip';
    // String uri = 'http://43.201.21.32:80/chat/tip';

    await http.post(Uri.parse(uri),
        headers: <String, String>{'Content-Type': "application/json"},
        body: jsonEncode(<String, dynamic>{
          'idx': index,
          'chat_id': chatId,
        }));
  }

// TTS
  Future speak(String text) async {
    try {
      AudioPlayer audioPlayer = AudioPlayer();
      final input = SynthesisInput(text: text);
      final voice = VoiceSelectionParams(
          languageCode: 'en-US',
          name: context.read<ProviderChat>().randomVoice);
      final audioConfig = AudioConfig(audioEncoding: "MP3");

      final synthesizeSpeechRequest = SynthesizeSpeechRequest(
          audioConfig: audioConfig, input: input, voice: voice);

      SynthesizeSpeechResponse synthesizeSpeechResponse =
      await TexttospeechApi(client)
          .text
          .synthesize(synthesizeSpeechRequest);

      List<int> audioContent = synthesizeSpeechResponse.audioContentAsBytes;

      if (Platform.isAndroid) {
        Source source = BytesSource(Uint8List.fromList(audioContent));
        audioPlayer.play(source);
      } else {
        Directory tempDir = await getTemporaryDirectory();
        final file = File('${tempDir.path}/TTS.wav');
        await file.writeAsBytes(audioContent);
        audioPlayer.play(DeviceFileSource('${tempDir.path}/TTS.wav'));
      }
    } catch (error) {
      print(error);
    }
  }

  Future sendToBE(String input) async {
    String uri = 'http://101.101.209.54:80/chat/insertDB';
    // String uri = 'http://43.201.21.32:80/chat/insertDB';

    http.Response response = await http.post(Uri.parse(uri),
        headers: <String, String>{'Content-Type': "application/json"},
        body: jsonEncode(<String, dynamic>{
          'text': input,
          'chat_id': chatId,
        }));
    String responseBody = utf8.decode(response.bodyBytes);
    Map<String, dynamic> responseMap = json.decode(responseBody);

    return responseMap['result'];
  }

  Future getRecommend(int index) async {
    String uri = 'http://101.101.209.54:80/chat/recommend';
    // String uri = 'http://43.201.21.32:80/chat/recommend';

    http.Response response = await http.post(Uri.parse(uri),
        headers: <String, String>{'Content-Type': "application/json"},
        body: jsonEncode(<String, dynamic>{
          'idx': index,
          'chat_id': chatId,
        }));
    String responseBody = utf8.decode(response.bodyBytes);
    Map<String, dynamic> responseMap = json.decode(responseBody);

    int idx = responseMap['idx'];
    String recommendedAnswer = responseMap['recommended answer'];

    ChatInChat chatInChat = chatList[idx];
    chatInChat.helpText = [recommendedAnswer];

    chatList[idx] = chatInChat;

    setState(() {});
  }

  Future askGPT(String input) async {
    String uri = 'http://101.101.209.54:80/chat/askGPT';
    // String uri = 'http://43.201.21.32:80/chat/askGPT';

    http.Response response = await http.post(Uri.parse(uri),
        headers: <String, String>{'Content-Type': "application/json"},
        body: jsonEncode(<String, dynamic>{
          'text': input,
          'chat_id': chatId,
        }));
    String responseBody = utf8.decode(response.bodyBytes);
    Map<String, dynamic> responseMap = json.decode(responseBody);

    bool finish = responseMap['finish'];
    String result = responseMap['result'];

    // 빙글빙글 도는 점 삭제
    chatList.removeLast();

    // recommend 제외 값 삽입
    chatList
        .add(ChatInChat(DateTime.now(), result, 'GPT', false, [''], !finish));
    setState(() {});

    if (!finish) {
      getRecommend(chatList.length - 1);
    }

    await speak(result);

    setState(() {
      canSpeak = true;
    });

    if (finish) {
      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (context) {
            return const FinishDialog();
          });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.watch<ProviderChat>().chatTitle,
          style: textTheme().displayMedium,
        ),
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: recorder.isRecording ?? false,
        glowColor: Colors.red,
        endRadius: 75.0,
        duration: const Duration(milliseconds: 1000),
        repeatPauseDuration: const Duration(milliseconds: 100),
        repeat: true,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            surfaceTintColor: Colors.white,
            backgroundColor:
            recorder.isRecording ?? false ? Colors.red : Colors.amber,
            shape: const CircleBorder(),
          ),
          onPressed: () async {
            if (recorder.isRecording ?? false) {
              transcribe(chatList[chatList.length-1].chat);
            } else if (recorder.isRecording == false && canSpeak == true) {
              await recorder.record();
              setState(() {});
            }
          },
          child: SizedBox(
            height: 75,
            width: 75,
            child: Icon(
              recorder.isRecording ?? false ? Icons.stop : Icons.mic,
              size: 50,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Scrollbar(
        controller: scrollController,
        thumbVisibility: true,
        child: Container(
          padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
          child: Column(children: [
            Expanded(
              child: MessagesInChat(
                chatList: chatList,
                scrollController: scrollController,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}