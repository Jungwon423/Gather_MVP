import 'package:flutter/material.dart';
import 'package:gather_mvp/ChatPages/goal/immigration_goal.dart';

import '../widgets/Chat.dart';

class Immigration extends StatelessWidget {
  const Immigration({Key? key}) : super(key: key);

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
            ImmigrationGoal(),
            NewChatScreen(
              initialChat:
                  'Hello, welcome to the United States. May I see your passport and travel documents, please?',
              problem: '입국 심사',
            )
          ])),
    );
  }
}
