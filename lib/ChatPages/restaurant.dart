import 'package:flutter/material.dart';

import '../widgets/Chat.dart';
import 'goal/restaurant_goal.dart';

class Restaurant extends StatelessWidget {
  const Restaurant({Key? key}) : super(key: key);

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
            RestaurantGoal(),
            NewChatScreen(
              initialChat: 'TODO', problem: 'TODO', // TODO
            )
          ])),
    );
  }
}
