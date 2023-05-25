import 'package:flutter/material.dart';
import 'package:googleapis_auth/auth_io.dart';

import '../../Google_API_Credentials.dart';
import '../../theme.dart';
import '../../widgets/widgets___goal.dart';

class HotelGoal extends StatefulWidget {
  const HotelGoal({Key? key}) : super(key: key);

  @override
  State<HotelGoal> createState() => _HotelGoalState();
}

class _HotelGoalState extends State<HotelGoal> {
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
                          '호텔에서 대화',
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
                        missionContainer('체크인하기'),
                        missionContainer('짐 맡겨달라고 요청하기'),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          '핵심 표현',
                          style:
                              textTheme().displayMedium!.copyWith(fontSize: 20),
                        ),
                        expressionContainer(
                            '안녕하세요. (아침, 낮, 밤)',
                            'Good morning. / Good afternoon. / Good evening.',
                            context,
                            client),
                        expressionContainer(
                            '체크인 부탁합니다.', 'check in please.', context, client),
                        expressionContainer('네.', 'yes', context, client),
                        expressionContainer(
                            'Wi-Fi는 있나요?', 'Is there Wi-Fi?', context, client),
                        expressionContainer('짐을 맡겨도 될까요?',
                            'Can I leave my luggage?', context, client),
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
