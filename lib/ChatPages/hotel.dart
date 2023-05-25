import 'package:flutter/material.dart';
import 'package:gather_mvp/ChatPages/goal/hotel_goal.dart';

import '../widgets/Chat.dart';

class Hotel extends StatelessWidget {
  const Hotel({Key? key}) : super(key: key);

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
            HotelGoal(),
            NewChatScreen(
              initialChat:
                  'Hello and welcome to The Ritz-Carlton New York. How may I assist you today?',
              problem: '호텔 체크인',
            )
          ])),
    );
  }
}
