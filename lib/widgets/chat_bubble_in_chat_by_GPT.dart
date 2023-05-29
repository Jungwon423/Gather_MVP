import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:googleapis_auth/auth_io.dart';

import '../../Google_API_Credentials.dart';
import '../../theme.dart';

import 'widgets___chat_bubble.dart';

class ChatBubbleInChatByGPT extends StatefulWidget {
  ChatBubbleInChatByGPT(this.message, this.helpText, this.tipExist,
      {Key? key, required this.voice, required this.isMobile})
      : super(key: key);

  final String message;
  final List<String> helpText;
  final bool tipExist;
  String voice;
  bool isMobile;

  @override
  State<ChatBubbleInChatByGPT> createState() => _ChatBubbleInChatByGPTState();
}

class _ChatBubbleInChatByGPTState extends State<ChatBubbleInChatByGPT> {
  late AutoRefreshingAuthClient client;
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    initAPI();
    super.initState();
  }

  Future<void> initAPI() async {
    client = await clientViaServiceAccount(
        credentials, ['https://www.googleapis.com/auth/cloud-platform']);
  }

  bool fold = false;
  bool translate = false;
  bool translateHelp = false;

  Future<void> gaEvent(String eventName, Map<String, dynamic> eventParams) async
  {
    await FirebaseAnalytics.instance.logEvent(
        name: eventName,
        parameters: eventParams
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: 8.h, horizontal: screenWidth * 0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: !widget.isMobile ?  screenWidth / 4.5 : screenWidth/2.25,
            constraints: BoxConstraints(
                maxWidth: !widget.isMobile ?  screenWidth / 4.5 : screenWidth/2.25),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        listenButton(() {
                          speak(widget.message, context, client, widget.voice);
                          setState(() {
                            gaEvent('click_listen',{
                              'color':'red'
                            });
                          });
                        }, widget.isMobile),
                        translateButton(() {
                          setState(() {
                            gaEvent('click_translate',{
                              'color':'red'
                            });
                            translate = !translate;
                          });
                        }, translate, widget.isMobile),
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      widget.message,
                      style: textTheme()
                          .displayLarge!
                          .copyWith(fontSize: !widget.isMobile ? 15.sp : 30.sp,fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    if (translate) translateText(widget.message, widget.isMobile)
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
