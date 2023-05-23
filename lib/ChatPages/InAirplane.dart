import 'package:flutter/material.dart';
import 'package:gather_mvp/widgets/Chat.dart';

import 'goal/inAirplane_goal.dart';

class InAirplane extends StatelessWidget {
  const InAirplane({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.fitWidth,
            image: AssetImage('assets/images/스케치북2.png')),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body:
          Row(children: [InAirplaneGoal(), NewChatScreen()])
      ),
    );
  }
}
