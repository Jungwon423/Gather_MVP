import 'package:flutter/material.dart';
import 'package:gather_mvp/ChatPages/widgets/PageFormat.dart';
import 'package:gather_mvp/models/expression.dart';

class Hotel extends StatelessWidget {
  const Hotel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageFormat(
      situation: '호텔 직원과 대화',
        missionList: [
          '체크인하기',
          '짐 맡겨달라고 요청하기'
        ],
        expressionList: [
          Expression('안녕하세요, [당신의 이름]으로 예약했습니다.',
              'Hello, I have a reservation under the name [your name].'),
          Expression('[숫자]박 예약했어요.', 'I booked a room for [number] nights.'),
          Expression('금연실로 부탁해요.', 'Could I have a non-smoking room, please?'),
          Expression('체크인/체크아웃 시간이 언제인가요?', 'What time is check-in/check-out?'),
          Expression(
              '예약금을 위해 제 카드 드립니다.', 'Here\'s my credit card for the deposit.'),
          Expression('체크인 전에 여기에 짐을 맡길 수 있나요?',
              'Can I leave my luggage here before check-in?'),
          Expression('짐을 맡길 수 있는 짐 보관실이 있나요?',
              'Is there a luggage storage area where I can leave my bags?'),
          Expression(
              '짐 보관에 얼마가 들어가나요?', 'How much does it cost to store my luggage?'),
          Expression('짐이 안전하게 보관될까요?', 'Will my luggage be secure?'),
          Expression('[시간]에 짐을 찾아도 될까요?', 'Can I pick up my luggage at [time]?')
        ],
        initialChat:
            ['Hello and welcome to The Ritz-Carlton New York. How may I assist you today?'],
        problem: '호텔 체크인', voice: 'en-US-Studio-M',);
  }
}
