import 'package:flutter/material.dart';
import 'package:gather_mvp/ChatPages/widgets/PageFormat.dart';

import '../models/expression.dart';

class AskForNumber extends StatelessWidget {
  const AskForNumber({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageFormat(
      situation: '마음에 드는 친구와 대화',
      missionList: ['마음에 드는 친구에게 번호 물어보기'],
      expressionList: [
        Expression('안녕하세요, 우리 서로 연락처를 교환하면 어떨까요?',
            'Hello, would you like to exchange phone numbers?'),
        Expression('우리 번호 공유하면 정말 좋을 것 같아요. 제 번호 어떠세요?',
            'I think it would be great if we could share our numbers. What do you think?'),
        Expression('내가 혹시 너에게 연락하는 방법을 알 수 있을까?',
            'Is there any way I can contact you?'),
        Expression('혹시 시간되면 같이 커피도 한잔 하고 싶은데, 연락처 주시면 좋겠어요.',
            'I would love to grab a coffee with you sometime if you are available. Could I have your contact number?'),
        Expression('나중에 만나서 같이 이야기하고 싶은데, 전화번호를 알 수 있을까요?',
            'I would like to meet up and chat sometime, can I have your phone number?'),
        Expression('다양한 주제로 대화를 나누고 싶은데, 전화번호 주실 수 있나요?',
            'I\'d love to have more conversations on various topics, may I have your phone number?'),
        Expression('우린 같은 관심사를 공유하고 있어서, 연락할 수 있는 방법이 있으면 좋겠어요. 전화번호 알려주실래요?',
            'Since we share the same interests, I\'d love to stay in touch. Could you give me your phone number?'),
        Expression('오늘 대화가 정말 즐거웠어요. 연락처를 주실 수 있으세요?',
            'I really enjoyed talking to you today. Can I have your contact information?'),
      ],
      initialChat: [
        'Hi, I just wanted to say that you\'re really beautiful.',
        'Thank you for the compliment! I really appreciate it.'
      ],
      problem: '길가던 여자 번호 따기',
      voice: 'en-US-Wavenet-H',
    );
  }
}
