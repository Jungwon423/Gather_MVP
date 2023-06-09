import 'dart:convert';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gather_mvp/widgets/sound_recorder.dart';
import 'package:gather_mvp/widgets/widgets___chat_bubble.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;

import '../Google_API_Credentials.dart';
import '../models/chat_in_chat.dart';
import 'messages_in_chat.dart';

// ignore: must_be_immutable
class MobileChat extends StatefulWidget {
  MobileChat(
      {super.key,
      required this.initialChat,
      required this.problem,
      required this.voice});

  List<String> initialChat;
  String problem;
  String voice;

  @override
  State<MobileChat> createState() => _MobileChatState();
}

class _MobileChatState extends State<MobileChat> {
  bool clicked = false;
  SoundRecorder recorder = SoundRecorder();

  int voiceIndex = 0;
  String chatId = '';

  List<ChatInChat> chatList = [];
  late AutoRefreshingAuthClient client;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    if (widget.initialChat.length == 1) {
      chatList.add(ChatInChat(
          DateTime.now(), widget.initialChat[0], 'GPT', false, [''], true));
    } else {
      for (int i = 0; i < widget.initialChat.length; i++) {
        chatList.add(ChatInChat(DateTime.now(), widget.initialChat[i],
            i % 2 == 0 ? 'me' : 'GPT', false, [''], false));
      }
    }

    // Chat collection 연결
    makeChat();

    // Google API 연결 - speak - microphone 권한 획득
    initAPI().then((value) => speak(
            widget.initialChat[widget.initialChat.length - 1],
            context,
            client,
            widget.voice)
        .then((value) => recorder.init()));
  }

  Future sendDevice() async {
    String uri = 'https://ai.zigdeal.shop:443/english/device';

    await http.post(Uri.parse(uri),
        headers: <String, String>{'Content-Type': "application/json"},
        body: jsonEncode(<String, dynamic>{
          "chat_id": chatId,
          "width": MediaQuery.of(context).size.width,
          "height": MediaQuery.of(context).size.height,
        }));
  }

  Future makeChat() async {
    String uri = 'https://ai.zigdeal.shop:443/english/makeChat';

    http.Response response = await http.post(Uri.parse(uri),
        headers: <String, String>{'Content-Type': "application/json"},
        body: jsonEncode(<String, dynamic>{"problem": widget.problem}));

    String responseBody = utf8.decode(response.bodyBytes);
    Map<String, dynamic> responseMap = json.decode(responseBody);

    print(responseMap);

    chatId = responseMap['chat_id'];
  }

  Future<void> initAPI() async {
    client = await clientViaServiceAccount(
        credentials, ['https://www.googleapis.com/auth/cloud-platform']);
  }

  // 녹음 종료 버튼 누름
  void transcribe(String prompt) async {
    await recorder.stop();

    // WaitingChatBubble 추가
    chatList.add(ChatInChat(DateTime.now(), "", 'me', true, [''], false));
    setState(() {});

    // 내가 말한 걸 whisper로 text 변환
    String transcribe = await recorder.transcribe(prompt);

    if (transcribe != 'error' && transcribe != 'recorder not playing') {
      chatList.removeLast();
      chatList
          .add(ChatInChat(DateTime.now(), transcribe, 'me', false, [''], true));
      setState(() {});

      // WaitingChatBubble 추가
      chatList.add(ChatInChat(DateTime.now(), "", 'waiting', true, [''], true));
      setState(() {});

      // BE에 text를 보내서 각각 tip과 GPT의 대답을 얻어낸다.
      askGPT(transcribe);
    }
  }

  Future askGPT(String input) async {
    print('askGPT 시작');
    String uri = 'https://ai.zigdeal.shop:443/english/askGPT';
    print(chatId);
    http.Response response = await http.post(Uri.parse(uri),
        headers: <String, String>{'Content-Type': "application/json"},
        body: jsonEncode(<String, dynamic>{
          'text': input,
          'chat_id': chatId,
        }));
    String responseBody = utf8.decode(response.bodyBytes);
    Map<String, dynamic> responseMap = json.decode(responseBody);

    String result = responseMap['result'];

    // 빙글빙글 도는 점 삭제
    chatList.removeLast();

    // recommend 제외 값 삽입
    chatList.add(ChatInChat(DateTime.now(), result, 'GPT', false, [''], false));
    setState(() {});

    await speak(result, context, client, widget.voice);
  }

  @override
  void dispose() {
    recorder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      width: screenWidth,
      height: screenHeight,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: AvatarGlow(
          animate: recorder.isRecording,
          glowColor: Colors.red,
          endRadius: 75.0.h,
          duration: const Duration(milliseconds: 1000),
          repeatPauseDuration: const Duration(milliseconds: 100),
          repeat: true,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              surfaceTintColor: Colors.white,
              backgroundColor: recorder.isRecording ? Colors.red : Colors.amber,
              shape: const CircleBorder(),
            ),
            onPressed: () async {
              if (!clicked) {
                clicked = true;
                sendDevice();
              }
              print('recorder 상태 : ' + recorder.isRecording.toString());
              if (recorder.isRecording) {
                print('recorder 녹음 종료');
                transcribe(chatList[chatList.length - 1].chat);
              } else if (recorder.isRecording == false) {
                print('recorder 녹음 시작');
                await recorder.record();
                setState(() {});
              }
            },
            child: SizedBox(
              height: 75.h,
              width: 75.w,
              child: Icon(
                recorder.isRecording ? Icons.stop : Icons.mic,
                size: 50.sp,
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
              if (screenHeight > screenWidth * 2119 / 3277 * 2)
                SizedBox(
                  height: (screenHeight - screenWidth * 2119 / 3277 * 2) / 2,
                ),
              Expanded(
                child: MessagesInChat(
                  chatList: chatList,
                  scrollController: scrollController,
                  voice: widget.voice,
                  isMobile: true,
                ),
              ),
              if (screenHeight > screenWidth * 2119 / 3277 * 2)
                SizedBox(
                  height: (screenHeight - screenWidth * 2119 / 3277 * 2) / 2,
                ),
            ]),
          ),
        ),
      ),
    );
  }
}
