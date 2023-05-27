import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:googleapis_auth/auth_io.dart';

import '../../Google_API_Credentials.dart';
import '../../models/expression.dart';
import '../../theme.dart';
import '../../widgets/widgets___goal.dart';

class Goal extends StatefulWidget {
  Goal(
      {Key? key,
      required this.situation,
      required this.missionList,
      required this.expressionList})
      : super(key: key);

  String situation;
  List<String> missionList;
  List<Expression> expressionList;

  @override
  State<Goal> createState() => _GoalState();
}

class _GoalState extends State<Goal> {
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
    double screenheight = MediaQuery.of(context).size.height;
    print(screenWidth);
    print(screenheight);
    return FutureBuilder(
      future: initAPI(),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return SizedBox(
              // width: screenWidth / 2,
              child: Center(child: CircularProgressIndicator()));
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
                    height: screenheight > screenWidth * 2119 / 3277 ? (screenWidth * 2119 / 3277)*0.95:screenheight,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: const BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Center(
                              child: Text(
                            widget.situation,
                            style:
                                textTheme().displayLarge!.copyWith(fontSize: 30.sp),
                          )),
                          SizedBox(
                            height: 30.h,
                          ),
                          Text(
                            '미션',
                            style:
                                textTheme().displayMedium!.copyWith(fontSize: 20.h),
                          ),
                          for (int i = 0; i < widget.missionList.length; i++)
                            missionContainer(widget.missionList[i]),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            '핵심 표현',
                            style:
                                textTheme().displayMedium!.copyWith(fontSize: 20.h),
                          ),
                          for (int i = 0; i < widget.expressionList.length; i++)
                            expressionContainer(
                                widget.expressionList[i].korean,
                                widget.expressionList[i].english,
                                context,
                                client),
                        ],
                      ),
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
