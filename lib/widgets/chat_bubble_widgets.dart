import 'dart:convert';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/texttospeech/v1.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../Provider/provider_chat.dart';

import 'package:http/http.dart' as http;

import '../../theme.dart';

// TTS
Future speak(String text, BuildContext context, AutoRefreshingAuthClient client,
    AudioPlayer audioPlayer) async {
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

    Source source = BytesSource(Uint8List.fromList(audioContent));
    audioPlayer.play(source);
  } catch (error) {
    print(error);
  }
}

// 번역 API
Future translateAPI(String text) async {
  String uri = 'https://naveropenapi.apigw.ntruss.com/nmt/v1/translation';

  http.Response response = await http.post(Uri.parse(uri),
      headers: <String, String>{
        'Content-Type': "application/json",
        'X-NCP-APIGW-API-KEY-ID': 'mhpdvzefox',
        'X-NCP-APIGW-API-KEY': 'yL2DMqFy986OsxDZx4rDtWV0pl55XlcAoJ4qXHa3'
      },
      // INPUT 형식
      body: jsonEncode(
          <String, dynamic>{'source': 'en', 'target': 'ko', 'text': text}));
  //
  Map<String, dynamic> responseMap = json.decode(response.body);

  String translatedText = responseMap['message']['result']['translatedText'];

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
