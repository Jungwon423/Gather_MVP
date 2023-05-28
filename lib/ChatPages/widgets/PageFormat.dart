import 'package:flutter/material.dart';

import '../../models/expression.dart';
import '../../widgets/Chat.dart';
import '../../widgets/mobileChat.dart';
import 'Goal.dart';

class PageFormat extends StatelessWidget {
  PageFormat(
      {Key? key,
      required this.situation,
      required this.missionList,
      required this.expressionList,
      required this.initialChat,
      required this.problem,
      required this.voice})
      : super(key: key);

  String situation;
  List<String> missionList;
  List<Expression> expressionList;
  List<String> initialChat;
  String problem;
  String voice;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth < 1000
        ? shortScreen(initialChat, problem, voice)
        : longScreen(situation, missionList, expressionList, initialChat,
            problem, voice);
  }
}

Container longScreen(
    String situation,
    List<String> missionList,
    List<Expression> expressionList,
    List<String> initialChat,
    String problem,
    String voice) {
  return Container(
    decoration: const BoxDecoration(
      image: DecorationImage(
          fit: BoxFit.fitWidth, image: AssetImage('assets/images/스케치북2.png')),
    ),
    child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Row(children: [
          Goal(
            situation: situation,
            missionList: missionList,
            expressionList: expressionList,
          ),
          NewChatScreen(
            initialChat: initialChat,
            problem: problem,
            voice: voice,
          )
        ])),
  );
}

Container shortScreen(List<String> initialChat, String problem, String voice) {
  return Container(
    decoration: const BoxDecoration(
      image: DecorationImage(
          fit: BoxFit.fitWidth,
          image: AssetImage('assets/images/스케치북1페이지.png')),
    ),
    child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Row(children: [
          MobileChat(
            initialChat: initialChat,
            problem: problem,
            voice: voice,
          )
        ])),
  );
}
