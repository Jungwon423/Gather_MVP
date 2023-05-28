import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:googleapis/texttospeech/v1.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:provider/provider.dart';

import '../../Provider/provider_chat.dart';

import '../../theme.dart';

import 'dart:html' as html;
import 'package:http/http.dart' as http;

// TTS
Future speak(String text, BuildContext context, AutoRefreshingAuthClient client,
    String voiceType) async {
  String randomVoice = context.read<ProviderChat>().randomVoice.toString();
  print(randomVoice);
  try {
    final input = SynthesisInput(text: text);
    final voice = VoiceSelectionParams(
        languageCode: 'en-US',
        name: voiceType == ''
            ? randomVoice
            : voiceType);
    final audioConfig = AudioConfig(audioEncoding: "MP3");

    final synthesizeSpeechRequest = SynthesizeSpeechRequest(
        audioConfig: audioConfig, input: input, voice: voice);

    SynthesizeSpeechResponse synthesizeSpeechResponse =
        await TexttospeechApi(client).text.synthesize(synthesizeSpeechRequest);

    List<int> audioContent = synthesizeSpeechResponse.audioContentAsBytes;

    final blob = html.Blob([audioContent], 'audio/mpeg');

    // Create a URL pointing to the Blob and create an AudioElement
    final blobUrl = html.Url.createObjectUrlFromBlob(blob);
    final audioElement = html.AudioElement(blobUrl);

    // Play the audio file
    audioElement.play();
  } catch (error) {
    print(error);
  }
}

// // 일본 TTS
// Future speakJapanese(
//     String text, BuildContext context, AutoRefreshingAuthClient client) async {
//   try {
//     final input = SynthesisInput(text: text);
//     final voice = VoiceSelectionParams(
//         languageCode: 'ja-JP', name: 'ja-JP-Neural2-B'); // TODO : 일본어 랜덤으로
//     final audioConfig = AudioConfig(audioEncoding: "MP3");
//
//     final synthesizeSpeechRequest = SynthesizeSpeechRequest(
//         audioConfig: audioConfig, input: input, voice: voice);
//
//     SynthesizeSpeechResponse synthesizeSpeechResponse =
//         await TexttospeechApi(client).text.synthesize(synthesizeSpeechRequest);
//
//     List<int> audioContent = synthesizeSpeechResponse.audioContentAsBytes;
//
//     final blob = html.Blob([audioContent], 'audio/mpeg');
//
//     // Create a URL pointing to the Blob and create an AudioElement
//     final blobUrl = html.Url.createObjectUrlFromBlob(blob);
//     final audioElement = html.AudioElement(blobUrl);
//
//     // Play the audio file
//     audioElement.play();
//   } catch (error) {
//     print(error);
//   }
// }

// 번역 API
Future translateAPI(String text) async {
  String translatedText = 'TODO : 백엔드로 translate API 만들기';

  String uri = 'https://ai.zigdeal.shop:443/english/translate';

  http.Response response = await http.post(Uri.parse(uri),
      headers: <String, String>{'Content-Type': "application/json"},
      body: jsonEncode(<String, dynamic>{"text": text}));

  String responseBody = utf8.decode(response.bodyBytes);
  Map<String, dynamic> responseMap = json.decode(responseBody);

  print(responseMap);

  translatedText = responseMap['result'];

  return translatedText;
}

// 번역된 텍스트
FutureBuilder translateText(String text, bool isMobile) {
  return FutureBuilder(
      future: translateAPI(text),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData == false) {
          // ignore: prefer_const_constructors
          return Column(children: [
            SizedBox(
              height: 30.h,
            ),
            Center(
              child: CircularProgressIndicator(
                color: Colors.amber,
              ),
            )
          ]);
        } else if (snapshot.hasError) {
          return const Text("에러 발생");
        } else {
          return Column(children: [
            SizedBox(
              height: 10.h,
            ),
            Text(
              snapshot.data,
              style: textTheme().displayLarge!.copyWith(
                fontSize: !isMobile ? 15.sp : 30.sp,
                  color: Colors.blueAccent, fontWeight: FontWeight.w500),
            ),
          ]);
        }
      });
}

// 접기/펼치기 버튼
ElevatedButton foldButton(VoidCallback onPressed, bool fold) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
        elevation: 3,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
    onPressed: onPressed,
    child: Center(
      child: Text(
        fold ? '펼치기' : '접기',
        style: textTheme().displayMedium,
      ),
    ),
  );
}

// 스피커 버튼
ConstrainedBox listenButton(VoidCallback onPressed, bool isMobile) {
  return ConstrainedBox(
    constraints: BoxConstraints.tightFor(width: !isMobile ? 40.w : 80.w),
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          fixedSize: Size(!isMobile ? 40.w : 80.w, !isMobile ? 40.w : 80.w),
          padding: EdgeInsets.zero,
          shape: const CircleBorder(),
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.grey[200]),
      child: Icon(
        Icons.volume_up_outlined,
        size: !isMobile ? 30.sp : 60.sp,
        color: Colors.black,
      ),
    ),
  );
}

// 작은 스피커 버튼
ConstrainedBox smallListenButton(VoidCallback onPressed) {
  return ConstrainedBox(
    constraints: BoxConstraints.tightFor(width: 40.w),
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          fixedSize: Size(30.sp, 30.sp),
          padding: EdgeInsets.zero,
          shape: const CircleBorder(),
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.grey[200]),
      child: Icon(
        Icons.volume_up_outlined,
        size: 30.sp,
        color: Colors.black,
      ),
    ),
  );
}

// 번역 버튼
ElevatedButton translateButton(VoidCallback onPressed, bool translate, bool isMobile) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
        elevation: 3,
        padding: EdgeInsets.symmetric(horizontal: !isMobile ? 10.w : 20.w),
        backgroundColor: Colors.grey[200],
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
    onPressed: onPressed,
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      Image.asset(
        'assets/images/translate.png',
        width: !isMobile ? 30.w : 60.w,
      ),
      SizedBox(
        width: !isMobile ? 10.w : 20.w,
      ),
      Text(
        translate ? '번역 닫기' : '번역하기',
        style: textTheme()
            .displayLarge!
            .copyWith(fontSize:!isMobile ?  15.sp : 30.sp, fontWeight: FontWeight.w700),
      )
    ]),
  );
}

// TIP
Column tipColumn(String tipSentence, String tipExplain) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(''),
      Text('🧑‍🏫 선생님이 교정해준 문장',
          style: textTheme().displayMedium!.copyWith(fontSize: 16.5.sp)),
      const Text(''),
      Text(tipSentence,
          style: textTheme().displaySmall!.copyWith(color: Colors.black)),
      const Text(''),
      Text("👆 TIP",
          style: textTheme().displayMedium!.copyWith(fontSize: 16.5.sp)),
      const Text(''),
      if (tipExplain != '')
        Text(tipExplain,
            style: textTheme().displaySmall!.copyWith(color: Colors.black)),
      if (tipExplain == '')
        Center(
          child: JumpingDots(
            color: Colors.amber,
            radius: 6.sp,
            numberOfDots: 3,
            animationDuration: Duration(milliseconds: 200),
          ),
        ),
    ],
  );
}
