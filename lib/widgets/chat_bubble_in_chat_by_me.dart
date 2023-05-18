import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:jumping_dot/jumping_dot.dart';

import '../../Google_API_Credentials.dart';
import '../../theme.dart';

import 'chat_bubble_widgets.dart';

class ChatBubbleInChatByMe extends StatefulWidget {
  const ChatBubbleInChatByMe(this.message, this.helpText, this.tipExist,
      {Key? key})
      : super(key: key);

  final String message;
  final List<String> helpText;
  final bool tipExist;

  @override
  State<ChatBubbleInChatByMe> createState() => _ChatBubbleInChatByMeState();
}

class _ChatBubbleInChatByMeState extends State<ChatBubbleInChatByMe> {
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 3,
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width / 3),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    listenButton(() {
                      speak(widget.message, context, client, audioPlayer);
                    }),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      widget.message,
                      style: textTheme()
                          .displayLarge!
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    translateButton(() {
                      setState(() {
                        translate = !translate;
                      });
                    }, translate),
                    if (translate) translateText(widget.message)
                  ],
                ),
              ),
              if (widget.tipExist == true)
                const Divider(thickness: 1.5, height: 30, color: Colors.black),
              if (widget.tipExist == true)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text('📒 커리비의 Tip',
                            style: textTheme().displayLarge!.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.w700)),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      if (fold == false)
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              widget.helpText[0] != ''
                                  ? tipColumn(
                                      widget.helpText[0], widget.helpText[1])
                                  : Center(
                                      child: JumpingDots(
                                        color: Colors.amber,
                                        radius: 6,
                                        numberOfDots: 3,
                                        animationDuration:
                                            Duration(milliseconds: 200),
                                      ),
                                    ),
                              const SizedBox(
                                height: 30,
                              ),
                            ]),
                      foldButton(() {
                        setState(() {
                          fold = !fold;
                        });
                      }, fold),
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
