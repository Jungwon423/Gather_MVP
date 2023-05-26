import 'package:flutter/material.dart';

import '../../models/expression.dart';
import '../../widgets/Chat.dart';
import 'Goal.dart';

class PageFormat extends StatelessWidget {
  PageFormat(
      {Key? key,
      required this.situation,
      required this.missionList,
      required this.expressionList,
      required this.initialChat,
      required this.problem})
      : super(key: key);

  String situation;
  List<String> missionList;
  List<Expression> expressionList;
  List<String> initialChat;
  String problem;

  @override
  Widget build(BuildContext context) {
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
            )
          ])),
    );
  }
}
