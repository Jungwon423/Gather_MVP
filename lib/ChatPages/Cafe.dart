import 'package:flutter/material.dart';
import 'package:gather_mvp/widgets/Chat.dart';

import 'goal/cafe_goal.dart';

class Cafe extends StatelessWidget {
  const Cafe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(children: [CafeGoal(), NewChatScreen()])
    );
  }
}
