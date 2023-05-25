import 'package:flutter/material.dart';
import 'package:gather_mvp/widgets/widgets___chat_bubble.dart';
import 'package:googleapis_auth/auth_io.dart';

import '../theme.dart';

Container circleDot(Color color) {
  return Container(
    width: 12,
    height: 12,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: color,
    ),
  );
}

Container missionContainer(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    decoration: const BoxDecoration(
      color: Colors.transparent,
      borderRadius: BorderRadius.all(
        Radius.circular(12),
      ),
    ),
    child: Row(children: [
      circleDot(Colors.amber),
      const SizedBox(
        width: 10,
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
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    decoration: const BoxDecoration(
      color: Colors.transparent,
      borderRadius: BorderRadius.all(
        Radius.circular(12),
      ),
    ),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        circleDot(Colors.black),
        const SizedBox(
          width: 10,
        ),
        Text(
          korean,
          style: textTheme().displayMedium,
        ),
        const SizedBox(
          width: 5,
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
