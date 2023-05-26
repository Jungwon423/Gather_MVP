import 'package:flutter/material.dart';
import 'package:gather_mvp/ChatPages/widgets/PageFormat.dart';

import '../models/expression.dart';

class Immigration extends StatelessWidget {
  const Immigration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageFormat(
        situation: '입국심사',
        missionList: ['입국심사 받기'],
        expressionList: [
          Expression(
              '안녕하세요, 여권 확인 부탁드립니다.', 'Hello, please check my passport.'),
          Expression('입국 목적이 무엇인가요?', 'What is the purpose of your visit?'),
          Expression('관광을 위해 왔습니다.', 'I am here for tourism.'),
          Expression('비즈니스를 위해 왔습니다.', 'I am here for business.'),
          Expression('친구/가족을 만나러 왔습니다.', 'I am here to visit friends/family.'),
          Expression('여행 기간은 얼마나 되나요?', 'How long will you be staying?'),
          Expression(
              '[숫자]일 동안 머무를 예정입니다.', 'I will be staying for [number] days.'),
          Expression('어디에 머무르실 예정인가요?', 'Where will you be staying?'),
          Expression(
              '저희는 [호텔 이름]에 머무를 예정입니다.', 'We will be staying at [hotel name].'),
          Expression('즐거운 여행되세요!', 'Enjoy your trip!')
        ],
        initialChat:
            ['Hello, welcome to the United States. May I see your passport and travel documents, please?'],
        problem: '입국 심사');
  }
}
