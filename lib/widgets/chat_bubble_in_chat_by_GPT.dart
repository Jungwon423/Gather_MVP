import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:googleapis_auth/auth_io.dart';

import '../../Google_API_Credentials.dart';
import '../../theme.dart';

import 'widgets___chat_bubble.dart';

class ChatBubbleInChatByGPT extends StatefulWidget {
  ChatBubbleInChatByGPT(this.message, this.helpText, this.tipExist,
      {Key? key, required this.voice})
      : super(key: key);

  final String message;
  final List<String> helpText;
  final bool tipExist;
  String voice;

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
            width: MediaQuery.of(context).size.width / 4.5,
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width / 4.5),
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
                        }),
                        translateButton(() {
                          setState(() {
                            translate = !translate;
                          });
                        }, translate),
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      widget.message,
                      style: textTheme()
                          .displayLarge!
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    if (translate) translateText(widget.message)
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
