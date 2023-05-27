import 'package:flutter/material.dart';
import 'package:gather_mvp/ChatPages/widgets/PageFormat.dart';

import '../models/expression.dart';

class Taxi extends StatefulWidget {
  const Taxi({Key? key}) : super(key: key);

  @override
  State<Taxi> createState() => _TaxiState();
}

class _TaxiState extends State<Taxi> {
  @override
  Widget build(BuildContext context) {
    return PageFormat(
      situation: '우버에서 대화',
      missionList: ['우버에서 기사에게 목적지 변경 요청하기'],
      expressionList: [
        Expression('안녕하세요, 제 방향이 맞는지 확인하려지 알려주실 수 있나요?',
            'Could you please tell me the scheduled pickup time for my ride?'),
        Expression('기사님, 현재 위치에서 제 위치까지 얼마나 걸리나요?',
            'Driver, how long will it take for you to reach my location from where you are now?'),
        Expression(
            '목적지 변경이 가능한가요?', 'Is it possible to change the destination?'),
        Expression('제가 중간에 정거장을 추가하려고 하는데이 가능할까요?',
            'I\'d like to add a stop along the way, is that possible?'),
        Expression('에어컨을 좀 더 높게 해 주실 수 있나요?',
            'Can you please turn up the air conditioning?'),
        Expression('소음을 줄이기 위해 창문을 닫아주실래요?',
            'Could you close the window to reduce the noise?'),
        Expression('비용이 얼마나 되나요?', 'How much does this ride cost?'),
      ],
      initialChat: ['Hello, welcome to my Uber. Where can I take you today?'],
      problem: '우버 택시',
      voice: 'en-US-News-N	',
    );
  }
}
