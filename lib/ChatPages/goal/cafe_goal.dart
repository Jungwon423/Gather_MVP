import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gather_mvp/theme.dart';

class CafeGoal extends StatelessWidget {
  const CafeGoal({Key? key}) : super(key: key);

  Container circleDot() {
    return Container(
      width: 5,
      height: 5,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.amber,
      ),
    );
  }

  Container expressionContainer() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Row(children: [
        circleDot(),
        SizedBox(width: 10,),
        Text(
          '자기소개를 하며 가벼운 대화 나누기',
          style: textTheme().displayMedium,
        )
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: screenWidth / 2,
      child: Scaffold(
        body: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '생일 물어보기',
                  style: textTheme().displayLarge,
                ),
                Text(
                  '미션',
                  style: textTheme().displayMedium,
                ),
                SizedBox(
                  height: 10,
                ),
                expressionContainer(),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '표현 공부',
                  style: textTheme().displayMedium,
                ),
                SizedBox(
                  height: 10,
                ),
                expressionContainer()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
