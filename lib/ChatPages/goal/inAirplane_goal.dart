import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gather_mvp/theme.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:googleapis_auth/googleapis_auth.dart';

import '../../Google_API_Credentials.dart';
import '../../widgets/widgets___goal.dart';

class InAirplaneGoal extends StatefulWidget {
  const InAirplaneGoal({Key? key}) : super(key: key);

  @override
  State<InAirplaneGoal> createState() => _InAirplaneGoalState();
}

class _InAirplaneGoalState extends State<InAirplaneGoal> {
  late AutoRefreshingAuthClient client;

  @override
  void initState() {
    super.initState();
  }

  Future<bool> initAPI() async {
    client = await clientViaServiceAccount(
        credentials, ['https://www.googleapis.com/auth/cloud-platform']);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return FutureBuilder(
      future: initAPI(),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return SizedBox(
              width: screenWidth / 2, child: CircularProgressIndicator());
        } else {
          return SizedBox(
            width: screenWidth / 2,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: screenWidth * 0.055),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
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
                          style:
                              textTheme().displayLarge!.copyWith(fontSize: 30),
                        )),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          '미션',
                          style:
                              textTheme().displayMedium!.copyWith(fontSize: 20),
                        ),
                        missionContainer('기내에서 승무원에게 필요한 것 요청하기'),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          '핵심 표현',
                          style:
                              textTheme().displayMedium!.copyWith(fontSize: 20),
                        ),
                        expressionContainer('죄송하지만 물 좀 주시겠어요?',
                            'すみませんが、お水をいただけますか?', context, client),
                        expressionContainer('실례지만 담요 좀 부탁드려도 될까요?',
                            'すみませんが、毛布をお願いできますか?', context, client),
                        expressionContainer(
                            '감사합니다.', 'ありがとうございます', context, client),
                        expressionContainer('음료의 종류는 무엇이 있나요?',
                            '飲み物の種類は何がありますか?', context, client),
                        expressionContainer('비행기 도착 시각을 알려 주시겠습니까?',
                            '飛行機の到着時刻を教えていただけますか?', context, client),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
