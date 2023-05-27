import 'package:flutter/material.dart';
import 'package:gather_mvp/ChatPages/widgets/PageFormat.dart';

import '../models/expression.dart';

class Starbucks extends StatefulWidget {
  const Starbucks({Key? key}) : super(key: key);

  @override
  State<Starbucks> createState() => _StarbucksState();
}

class _StarbucksState extends State<Starbucks> {
  @override
  Widget build(BuildContext context) {
    return PageFormat(situation: '스타벅스에서 대화',
        missionList: ['스타벅스에서 음료 주문하기'],
        expressionList: [Expression('톨 사이즈 [음료 이름] 주세요.', 'Hello, may I please have a tall [drink name]?'),
          Expression('그란데 사이즈의 [음료 이름] 주문하려고 합니다.', 'I\'d like to order a grande [drink name].'),
              Expression('벤티 사이즈 [음료 이름] 하나 주세요.', 'Can I get a venti [drink name], please?'),
          Expression('[우유/설탕/시럽/향료] 추가 부탁드립니다.', 'I\'d like my drink with [milk/sugar/syrup/flavoring] added in.'),
          Expression('저지방으로 만들어 주실 수 있나요?', 'Can you make it non-fat, please?'),
          Expression('아몬드 밀크나 두유 같은 다른 우유 옵션이 있나요?', 'Do you have any other milk options, like almond or soy milk?'),
          Expression('음료를 아이스로 해 주실 수 있나요?', 'Can I have my drink iced, please?'),
          Expression('뜨거운 [음료 이름]을 주문할게요.', 'Can I order a hot [drink name]?'),
          Expression('테이크아웃으로 부탁드립니다.', 'Can I get that to go, please?'),
          Expression('감사합니다, 좋은 하루 되세요!', 'Thank you, have a great day!')],
        initialChat: ['Hello, welcome to Starbucks! What can I get for you today?'],
        problem: '스타벅스', voice: 'en-US-Standard-F',);
  }
}