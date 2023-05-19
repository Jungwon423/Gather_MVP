import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:jumping_dot/jumping_dot.dart';

import '../../Google_API_Credentials.dart';
import '../../theme.dart';

import 'chat_bubble_widgets.dart';

class ChatBubbleInChatByGPT extends StatefulWidget {
  const ChatBubbleInChatByGPT(this.message, this.helpText, this.tipExist,
      {Key? key})
      : super(key: key);

  final String message;
  final List<String> helpText;
  final bool tipExist;

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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 100),
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
                const Divider(thickness: 1.5, height: 30, color: Colors.grey),
              if (widget.tipExist == true)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text('📒 커리비가 추천하는 답변',
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
                                  ? Text(widget.helpText[0],
                                      style: textTheme().displayLarge!.copyWith(
                                          color: Colors.grey[600],
                                          fontWeight: FontWeight.w500))
                                  : Center(
                                      child: JumpingDots(
                                        color: Colors.amber,
                                        radius: 6,
                                        numberOfDots: 3,
                                        animationDuration: Duration(milliseconds: 200),
                                      ),
                                    ),
                              const SizedBox(
                                height: 10,
                              ),
                              translateButton(() {
                                setState(() {
                                  translateHelp = !translateHelp;
                                });
                              }, translateHelp),
                              if (translateHelp)
                                translateText(widget.helpText[0]),
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
