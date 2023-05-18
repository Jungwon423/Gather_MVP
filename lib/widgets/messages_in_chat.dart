import 'package:flutter/material.dart';
import 'package:gather_mvp/widgets/waiting_chat.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../models/chat_in_chat.dart';
import 'chat_bubble_in_chat_by_GPT.dart';
import 'chat_bubble_in_chat_by_me.dart';

// ignore: must_be_immutable
class MessagesInChat extends StatelessWidget {
  List<ChatInChat> chatList;
  ScrollController scrollController;

  MessagesInChat(
      {Key? key, required this.chatList, required this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GroupedListView(
      controller: scrollController,
      shrinkWrap: true,
      order: GroupedListOrder.DESC,
      elements: chatList,
      groupBy: (ChatInChat chat) => 1,
      groupSeparatorBuilder: (index) => const SizedBox(),
      reverse: true,
      indexedItemBuilder: (context, ChatInChat chatInChat, index) {
        if (chatInChat.isWaiting) {
          return WaitingChatBubble(chatInChat.sender == 'me');
        } else if (chatInChat.sender == 'GPT') {
          return ChatBubbleInChatByGPT(
              chatInChat.chat, chatInChat.helpText, chatInChat.tipExist);
        } else {
          return ChatBubbleInChatByMe(
              chatInChat.chat, chatInChat.helpText, chatInChat.tipExist);
        }
      },
    );
  }
}
