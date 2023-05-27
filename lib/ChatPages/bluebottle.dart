import 'package:flutter/material.dart';
import 'package:gather_mvp/ChatPages/widgets/PageFormat.dart';

import '../models/expression.dart';

class Bluebottle extends StatefulWidget {
  const Bluebottle({Key? key}) : super(key: key);

  @override
  State<Bluebottle> createState() => _BluebottleState();
}

class _BluebottleState extends State<Bluebottle> {
  @override
  Widget build(BuildContext context) {
    return PageFormat(situation: '블루보틀에서 대화',
        missionList: ['블루보틀에서 음료 주문하기'],
        expressionList: [Expression('블루보틀 시그니처 드립 커피 하나 주세요.', 'Could I please have a Blue Bottle signature drip coffee?'),
          Expression('새벽에 빻은 콜드 브루 커피 하나 주세요.', 'I would like to order a Single Origin Cold Brew.'),
          Expression('카페 라떼 하나 주문하려고 합니다.', 'I\'d like to order a cafe latte, please.'),
          Expression('[우유/설탕/시럽/맛] 추가로 넣어 주실래요?', 'Can you please add [milk/sugar/syrup/flavoring]?'),
          Expression('우유 대신 오트 밀크로 변경 가능한가요?', 'Can I substitute the milk with oat milk?'),
          Expression('시키려는 커피에 가장 잘 어울리는 두유 옵션 뭐가 있나요?', 'What is the best milk alternative for the coffee I\'m ordering?'),
          Expression('음료를 아이스로 해 주실 수 있나요?', 'Can I have my drink iced, please?'),
          Expression('뜨거운 [음료 이름] 하나 주문할게요.', 'I would like to order a hot [drink name].'),
          Expression('테이크아웃으로 부탁드립니다.', 'Can I get my order to go, please?'),
          Expression('감사합니다! 좋은 하루 되세요!', 'Thank you! Have a great day!')],
        initialChat: ['Hello, welcome to Blue Bottle Coffee. What can I get for you today?'],
        problem: '블루보틀', voice: 'en-US-Wavenet-F',);
  }
}