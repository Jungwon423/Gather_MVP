import 'package:flutter/material.dart';
import 'package:jumping_dot/jumping_dot.dart';

class WaitingChatBubble extends StatelessWidget {
  const WaitingChatBubble(this.isMe, {Key? key}) : super(key: key);

  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 100),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            height: 50,
            constraints:
                BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 4.5),
            decoration: BoxDecoration(
              color: isMe ? Colors.white : Colors.grey[200],
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: JumpingDots(
              color: Colors.amber,
              radius: 6,
              numberOfDots: 3,
              animationDuration: Duration(milliseconds: 200),
            ),
          ),
        ],
      ),
    );
  }
}
