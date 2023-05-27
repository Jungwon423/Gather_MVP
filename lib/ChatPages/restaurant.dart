import 'package:flutter/material.dart';
import 'package:gather_mvp/ChatPages/widgets/PageFormat.dart';

import '../models/expression.dart';

class Restaurant extends StatelessWidget {
  const Restaurant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageFormat(
      situation: '식당에서 대화',
      missionList: ['음식점에서 먹고 싶은 메뉴 주문하기', '물 등 필요한 거 있으면 요청하기'],
      expressionList: [
        Expression('안녕하세요, 메뉴판 주세요.', 'Hello, could I have a menu, please?'),
        Expression(
            '이 요리는 무슨 재료로 만들어졌나요?', 'What are the ingredients in this dish?'),
        Expression(
            '특별 추천 메뉴가 있나요?', 'Do you have any special recommendations?'),
        Expression(
            '메뉴 중 무슨 것이 인기있나요?', 'Which dish is most popular on the menu?'),
        Expression(
            '일식 정식세트 주문하고 싶습니다.', 'I would like to order a Japanese set meal.'),
        Expression('회 세트를 주세요.', 'Please give me a sashimi set.'),
        Expression('돈까스를 주문하겠습니다.', 'I will order a tonkatsu.'),
        Expression('라멘 하나 주세요.', 'Can I have one ramen, please?'),
        Expression('초밥을 주문하겠습니다.', 'I will order sushi.'),
        Expression(
            '이 요리에 알레르기 유발 식재료가 있나요?', 'Does this dish contain any allergens?')
      ],
      initialChat: [
        'Hello, welcome to our restaurant. How may I assist you today?'
      ],
      problem: '일식집 주문', voice: 'en-US-Wavenet-J',
    );
  }
}
