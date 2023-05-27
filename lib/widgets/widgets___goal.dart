import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gather_mvp/widgets/widgets___chat_bubble.dart';
import 'package:googleapis_auth/auth_io.dart';

import '../theme.dart';

Container circleDot(Color color) {
  return Container(
    width: 12.w,
    height: 12.h,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: color,
    ),
  );
}

Container missionContainer(String text) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
    decoration: const BoxDecoration(
      color: Colors.transparent,
      borderRadius: BorderRadius.all(
        Radius.circular(12),
      ),
    ),
    child: Row(children: [
      circleDot(Colors.amber),
      SizedBox(
        width: 10.w,
      ),
      Text(
        text,
        style: textTheme().displayMedium,
      )
    ]),
  );
}

Container expressionContainer(String korean, String japanese,
    BuildContext context, AutoRefreshingAuthClient client) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
    decoration: const BoxDecoration(
      color: Colors.transparent,
      borderRadius: BorderRadius.all(
        Radius.circular(12),
      ),
    ),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        circleDot(Colors.black),
        SizedBox(
          width: 10.w,
        ),
        Text(
          korean,
          style: textTheme().displayMedium,
        ),
        SizedBox(
          width: 5.w,
        ),
        smallListenButton(
          () {
            speakJapanese(japanese, context, client);
          },
        )
      ]),
      Text(
        japanese,
        style: textTheme().displayMedium,
      )
    ]),
  );
}
