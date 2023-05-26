import 'package:flutter/material.dart';
import 'package:gather_mvp/ChatPages/widgets/PageFormat.dart';

import '../models/expression.dart';

class InAirplane extends StatelessWidget {
  const InAirplane({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageFormat(
      situation: '비행기에서 승무원과 대화',
      missionList: ['기내에서 승무원에게 필요한 것 요청하기'],
      expressionList: [
        Expression('안녕하세요, 저기 물 좀 받을 수 있을까요?',
            'Hello, could I have some water, please?'),
        Expression('기내식 메뉴가 어떻게 되나요?', 'What is the in-flight meal menu?'),
        Expression(
            '커피 대신 차를 마시고 싶은데 가능한가요?', 'Can I have tea instead of coffee?'),
        Expression('담요를 하나 더 받을 수 있을까요?', 'Could I have an extra blanket?'),
        Expression('목베개를 구할 수 있을까요?', 'Can I get a neck pillow?'),
        Expression(
            '비행기 도착 예정 시간이 언제인가요?', 'What is the estimated time of arrival?'),
        Expression('비행기에서 청소년이나 어린이에게 제공되는 서비스가 있나요?',
            'Are there any services provided for teens or children on the flight?'),
        Expression('선물 팩이나 면세품을 구입하고 싶습니다.',
            'I would like to purchase a gift pack or duty-free items.'),
        Expression('헤드폰을 받을 수 있을까요?', 'Could I have a pair of headphones?'),
        Expression('화장실이 어디에 있나요?', 'Where is the restroom?')
      ],
      initialChat: ['Excuse me, how can I help you?'],
      problem: '승무원과 대화',
    );
  }
}
