import 'package:flutter/material.dart';
import 'package:googleapis_auth/auth_io.dart';

import '../../Google_API_Credentials.dart';
import '../../theme.dart';
import '../../widgets/widgets___goal.dart';

class RestaurantGoal extends StatefulWidget {
  const RestaurantGoal({Key? key}) : super(key: key);

  @override
  State<RestaurantGoal> createState() => _RestaurantGoalState();
}

class _RestaurantGoalState extends State<RestaurantGoal> {
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
                          '식당에서 대화',
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
                        missionContainer('음식점에서 먹고 싶은 메뉴 주문하기'),
                        missionContainer('물 등 필요한 거 있으면 요청하기'),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          '핵심 표현',
                          style:
                              textTheme().displayMedium!.copyWith(fontSize: 20),
                        ),
                        expressionContainer(
                            '1명 / 2명 / 3명 / 4명 / 5명 / 6명 + 입니다.',
                            '一人 / 二人 / 三人 / 四人 / 五人 / 六人 + です。',
                            context,
                            client),
                        expressionContainer(
                            '주문 좀 할게요~', '注文お願いします。', context, client),
                        expressionContainer(
                            '이거 주세요.', 'これください。', context, client),
                        expressionContainer('얼마나 기다려야 하나요?',
                            'どれくらい待たないといけませんか。', context, client),
                        expressionContainer(
                            '물좀주세요.', 'お水ください。', context, client),
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
