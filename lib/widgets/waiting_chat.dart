import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jumping_dot/jumping_dot.dart';

class WaitingChatBubble extends StatelessWidget {
  const WaitingChatBubble(this.isMe, {Key? key}) : super(key: key);

  final bool isMe;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: screenWidth*0.05),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            height: 50.h,
            constraints:
                BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 4.5),
            decoration: BoxDecoration(
              color: isMe ? Colors.white : Colors.grey[200],
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
            margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
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
