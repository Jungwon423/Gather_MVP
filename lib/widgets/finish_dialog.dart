import 'package:flutter/material.dart';
import '../../theme.dart';

class FinishDialog extends StatelessWidget {
  const FinishDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var phonewidth = MediaQuery.of(context).size.width;

    return SimpleDialog(
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      titlePadding: const EdgeInsets.symmetric(vertical: 30),
      title: Column(children: [
        Text(
          "수업이 끝났어요 😊",
          style: textTheme().displayMedium!.copyWith(fontSize: 16),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "튜터의 더 자세한 피드백이 기다리고 있어요!",
          style: textTheme().displayMedium!.copyWith(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ]),
      children: [
        SizedBox(
          width: phonewidth - 100,
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        )
      ],
    );
  }
}
