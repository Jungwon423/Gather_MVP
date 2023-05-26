import 'package:flutter/material.dart';
import 'package:gather_mvp/ChatPages/widgets/PageFormat.dart';

import '../models/expression.dart';

class FoodtruckHotdog extends StatelessWidget {
  const FoodtruckHotdog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageFormat(
        situation: '핫도그 푸드트럭에서 대화',
        missionList: ['제일 맛있는 핫도그 물어보기', '핫도그에 토핑 추가하기'],
        expressionList: [
          Expression('안녕하세요, 어떤 종류의 핫도그가 있나요?',
              'Hello, what kinds of hot dogs do you have?'),
          Expression(
              '오리지널 핫도그 하나 주세요.', 'Can I have one original hot dog, please?'),
          Expression(
              '추가 토핑 종류가 무엇이 있나요?', 'What additional toppings are available?'),
          Expression('치즈와 양파를 추가해 주세요.', 'Please add cheese and onions.'),
          Expression(
              '스파이시 버전의 핫도그가 있나요?', 'Do you have a spicy version of hot dogs?'),
          Expression('비건 핫도그도 제공하나요?', 'Do you offer vegan hot dogs?'),
          Expression('이 핫도그는 어떤 소스가 들어가 있나요?',
              'What kind of sauce is in this hot dog?'),
          Expression('결제 방법은 어떻게 되나요?', 'What are the payment options?'),
          Expression('핫도그 외에 다른 메뉴들도 있나요?',
              'Do you have any other menu items besides hot dogs?'),
          Expression(
              '제일 인기 있는 핫도그는 어느 것인가요?', 'Which hot dog is the most popular?')
        ],
        initialChat: ['Welcome! How can I help you with your order?'],
        problem: '핫도그 푸드트럭');
  }
}
