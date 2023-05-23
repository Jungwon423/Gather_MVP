import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/texttospeech/v1.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:provider/provider.dart';

import '../../Provider/provider_chat.dart';

import '../../theme.dart';

import 'dart:html' as html;

// TTS
Future speak(
    String text, BuildContext context, AutoRefreshingAuthClient client) async {
  try {
    final input = SynthesisInput(text: text);
    final voice = VoiceSelectionParams(
        languageCode: 'en-US', name: context.read<ProviderChat>().randomVoice);
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

// 일본 TTS
Future speakJapanese(
    String text, BuildContext context, AutoRefreshingAuthClient client) async {
  try {
    final input = SynthesisInput(text: text);
    final voice = VoiceSelectionParams(
        languageCode: 'ja-JP', name: 'ja-JP-Neural2-B'); // TODO : 일본어 랜덤으로
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

// 번역 API
Future translateAPI(String text) async {
  String translatedText = 'TODO : 백엔드로 translate API 만들기';

  return translatedText;
}

// 번역된 텍스트
FutureBuilder translateText(String text) {
  return FutureBuilder(
      future: translateAPI(text),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData == false) {
          // ignore: prefer_const_constructors
          return Column(children: const [
            SizedBox(
              height: 30,
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
            const SizedBox(
              height: 10,
            ),
            Text(
              snapshot.data,
              style: textTheme().displayLarge!.copyWith(
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
ConstrainedBox listenButton(VoidCallback onPressed) {
  return ConstrainedBox(
    constraints: const BoxConstraints.tightFor(width: 40),
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          fixedSize: const Size(40, 40),
          padding: EdgeInsets.zero,
          shape: const CircleBorder(),
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.grey[200]),
      child: const Icon(
        Icons.volume_up_outlined,
        size: 30,
        color: Colors.black,
      ),
    ),
  );
}

// 작은 스피커 버튼
ConstrainedBox smallListenButton(VoidCallback onPressed) {
  return ConstrainedBox(
    constraints: const BoxConstraints.tightFor(width: 40),
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          fixedSize: const Size(30, 30),
          padding: EdgeInsets.zero,
          shape: const CircleBorder(),
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.grey[200]),
      child: const Icon(
        Icons.volume_up_outlined,
        size: 30,
        color: Colors.black,
      ),
    ),
  );
}

// 번역 버튼
ElevatedButton translateButton(VoidCallback onPressed, bool translate) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
        elevation: 3,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        backgroundColor: Colors.grey[200],
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
    onPressed: onPressed,
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      Image.asset(
        'assets/images/translate.png',
        width: 30,
      ),
      const SizedBox(
        width: 10,
      ),
      Text(
        translate ? '번역 닫기' : '번역하기',
        style: textTheme()
            .displayLarge!
            .copyWith(fontSize: 15, fontWeight: FontWeight.w700),
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
          style: textTheme().displayMedium!.copyWith(fontSize: 16.5)),
      const Text(''),
      Text(tipSentence,
          style: textTheme().displaySmall!.copyWith(color: Colors.black)),
      const Text(''),
      Text("👆 TIP",
          style: textTheme().displayMedium!.copyWith(fontSize: 16.5)),
      const Text(''),
      if (tipExplain != '')
        Text(tipExplain,
            style: textTheme().displaySmall!.copyWith(color: Colors.black)),
      if (tipExplain == '')
        Center(
          child: JumpingDots(
            color: Colors.amber,
            radius: 6,
            numberOfDots: 3,
            animationDuration: Duration(milliseconds: 200),
          ),
        ),
    ],
  );
}
