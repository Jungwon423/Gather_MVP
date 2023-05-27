import 'package:flutter/material.dart';
import 'package:gather_mvp/ChatPages/widgets/PageFormat.dart';

import '../models/expression.dart';

class AskCafe extends StatelessWidget {
  const AskCafe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageFormat(
        situation: '행인에게 카페 위치 묻기',
        missionList: ['행인에게 스타벅스 위치 묻기'],
        expressionList: [
          Expression('안녕하세요, 이 근처에 카페가 어디 있는지 아시나요?',
              'Hello, do you know where a cafe is located nearby?'),
          Expression('제가 찾고 있는 카페는 스타벅스인데, 혹시 여기 근처에 있나요?',
              'The cafe I am looking for is Starbucks, do you know if there is one nearby?'),
          Expression(
              '오른쪽이나 왼쪽으로 가야하나요?', 'Should I go to the right or to the left?'),
          Expression('몇 블록 떨어져 있나요?', 'How many blocks away is it?'),
          Expression(
              '카페까지 얼마나 걸리나요?', 'How long does it take to get to the cafe?'),
          Expression('도보로 갈 수 있나요, 아니면 탈것을 이용해야 하나요?',
              'Can I walk there, or do I need to use transportation?'),
          Expression('이 카페는 오늘 오픈되어 있나요?', 'Is this cafe open today?'),
          Expression('카페 영업 시간은 어떻게 되나요?',
              'What are the operating hours of the cafe?'),
          Expression(
              '이 카페에서 무료 와이파이를 제공하나요?', 'Does this cafe offer free Wi-Fi?'),
          Expression('이 근처에 또 다른 카페를 추천해주실 수 있나요?',
              'Can you recommend another cafe nearby?')
        ],
        initialChat: [
          'Excuse me, could you help me, please?',
          'Sure, what do you need help with?'
        ],
        problem: '행인에게 카페 위치 묻기', voice: 'en-US-Wavenet-H',);
  }
}
