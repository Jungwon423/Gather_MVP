import 'package:flutter/material.dart';
import 'package:gather_mvp/ChatPages/widgets/PageFormat.dart';

import '../models/expression.dart';

class FoodTruckIceCream extends StatefulWidget {
  const FoodTruckIceCream({Key? key}) : super(key: key);

  @override
  State<FoodTruckIceCream> createState() => _FoodTruckIceCreamState();
}

class _FoodTruckIceCreamState extends State<FoodTruckIceCream> {
  @override
  Widget build(BuildContext context) {
    return PageFormat(situation: '아이스크림 푸드트럭에서 대화',
        missionList: ['아이스크림 푸드트럭에서 아이스크림 주문하기'],
        expressionList: [Expression('안녕하세요, 어떤 종류의 아이스크림이 있나요?', 'Hello, what kinds of ice cream do you have?'),
          Expression('프레쉬 딸기 아이스크림을 주세요.', 'Can I have a fresh strawberry ice cream, please?'),
          Expression('맛이 어떻게 다른가요? 설탕 무첨가 아이스크림도 있나요?', 'What are the flavor differences? Do you have sugar-free ice cream?'),
          Expression('콘에 담긴 아이스크림과 컵에 담긴 아이스크림 중 어떤 것이 더 인기 있나요?', 'Which is more popular, ice cream in a cone or ice cream in a cup?'),
          Expression('초코렛 칩 아이스크림을 두 스쿱 주세요.', 'Please give me two scoops of chocolate chip ice cream.'),
          Expression('드레싱으로 과일 시럽을 추가해 주세요.', 'Please add fruit syrup as a topping.'),
          Expression('누가크런치 한 개, 바닐라 한 개 해주세요.', 'One scoop of cookie & cream, and one scoop of vanilla, please.'),
          Expression('간장 아이스크림이 어떤 맛인가요?', 'What does soy sauce ice cream taste like?'),
          Expression('비건 아이스크림이 있나요?', 'Do you have vegan ice cream options?'),
          Expression('결제 방법은 어떻게 되나요?', 'What are the payment options?')],
        initialChat: ['Hello! What flavor would you like to have today?'],
        problem: '아이스크림 푸드트럭');
  }
}
