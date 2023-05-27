import 'package:flutter/material.dart';
import 'package:gather_mvp/ChatPages/widgets/PageFormat.dart';

import '../models/expression.dart';

class BusStation extends StatelessWidget {
  const BusStation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageFormat(
        situation: '버스 정류장에서 길 묻기',
        missionList: ['자유의 여신상으로 가는 길 묻기'],
        expressionList: [
          Expression('안녕하세요, 자유의 여신상으로 가는 길을 알려주실 수 있나요?',
              'Hello, could you tell me how to get to the Statue of Liberty from here?'),
          Expression('자유의 여신상으로 가는 버스를 어느 정류장에서 타야 하나요?',
              'Which bus stop should I take to get to the Statue of Liberty?'),
          Expression('어느 버스 번호로 가야 하나요?', 'Which bus number should I take?'),
          Expression('버스를 탄 후 몇 정거장에서 내려야 하나요?',
              'How many stops do I have to get off after taking the bus?'),
          Expression('이 버스가 자유의 여신상 방향으로 가나요?',
              'Is this bus going in the direction of the Statue of Liberty?'),
          Expression('몇 분 정도 소요되나요?', 'How long does it take?'),
          Expression(
              '혹시 버스를 환승해야 하나요?', 'Do I need to transfer buses at any point?'),
          Expression('버스 요금은 어느 정도인가요?', 'What is the bus fare?'),
          Expression('버스 티켓은 어디에서 구매할 수 있나요?', 'Where can I buy a bus ticket?'),
          Expression('자유의 여신상까지 다른 교통 수단을 이용할 수도 있나요?',
              'Are there any other transportation options to get to the Statue of Liberty?')
        ],
        initialChat: [
          'Excuse me, could you help me, please?',
          'Sure, what do you need help with?'
        ],
        problem: '버스 정류장 앞', voice: 'en-US-Wavenet-I',);
  }
}
