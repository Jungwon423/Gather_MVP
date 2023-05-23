import 'package:flutter/material.dart';
import 'package:googleapis_auth/auth_io.dart';

import '../../Google_API_Credentials.dart';
import '../../theme.dart';

import 'widgets___chat_bubble.dart';

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

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: screenWidth*0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 4.5,
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width / 4.5),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        listenButton(() {
                          speak(widget.message, context, client);
                        }),
                        translateButton(() {
                          setState(() {
                            translate = !translate;
                          });
                        }, translate),
                      ],
                    ),
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
