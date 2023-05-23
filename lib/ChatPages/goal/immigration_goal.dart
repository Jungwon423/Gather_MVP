import 'package:flutter/material.dart';
import 'package:googleapis_auth/auth_io.dart';

import '../../Google_API_Credentials.dart';
import '../../theme.dart';
import '../../widgets/widgets___goal.dart';

class ImmigrationGoal extends StatefulWidget {
  const ImmigrationGoal({Key? key}) : super(key: key);

  @override
  State<ImmigrationGoal> createState() => _ImmigrationGoalState();
}

class _ImmigrationGoalState extends State<ImmigrationGoal> {
  late AutoRefreshingAuthClient client;

  @override
  void initState() {
    // Google API 연결
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initAPI();
    });

    super.initState();
  }

  Future<void> initAPI() async {
    client = await clientViaServiceAccount(
        credentials, ['https://www.googleapis.com/auth/cloud-platform']);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: screenWidth / 2,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.055),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: const BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                      child: Text(
                    '비행기에서 승무원과 대화',
                    style: textTheme().displayLarge!.copyWith(fontSize: 30),
                  )),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    '미션',
                    style: textTheme().displayMedium!.copyWith(fontSize: 20),
                  ),
                  missionContainer('기내에서 승무원에게 필요한 것 요청하기'),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    '핵심 표현',
                    style: textTheme().displayMedium!.copyWith(fontSize: 20),
                  ),
                  expressionContainer('죄송하지만 물 좀 주시겠어요?', 'すみませんが、お水をいただけますか?',
                      '스미마셍가 오미즈오 이타다케마스카', context, client),
                  expressionContainer(
                      '실례지만 담요 좀 부탁드려도 될까요?',
                      'すみませんが、毛布をお願いできますか?',
                      '스미마셍가 모오후오 오네가이데키마스카',
                      context,
                      client),
                  expressionContainer(
                      '감사합니다.', 'ありがとうございます', '아리가토오고자이마스', context, client),
                  expressionContainer('음료의 종류는 무엇이 있나요?', '飲み物の種類は何がありますか?',
                      '노미모노노 슈루이와 나니가 아리마스카', context, client),
                  expressionContainer(
                      '비행기 도착 시각을 알려 주시겠습니까?',
                      '飛行機の到着時刻を教えていただけますか?',
                      '히코오키노 토오차쿠지코쿠오 오시에테 이타다케마스카',
                      context,
                      client),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
