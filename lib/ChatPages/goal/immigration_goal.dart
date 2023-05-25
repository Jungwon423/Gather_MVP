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
                          '입국심사',
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
                        missionContainer('입국심사 받기'),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          '핵심 표현',
                          style:
                              textTheme().displayMedium!.copyWith(fontSize: 20),
                        ),
                        expressionContainer(
                            '여행입니다.', 'It\'s a trip.', context, client),
                        expressionContainer('일 때문에 왔습니다.',
                            'I\'m here for work.', context, client),
                        expressionContainer(
                            '기념품입니다.', 'This is a souvenir.', context, client),
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
