import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tandem_ai/features/chat/data/models/chat_list.dart';
import 'package:tandem_ai/features/chat/logic/cubit/chat_list_cubit.dart';
import 'chat_bubble.dart';

class ChatHistory extends StatelessWidget {
  const ChatHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final Chat? activeChat = context.read<ChatListCubit>().getActiveChat();

    return activeChat != null ? Padding(
      padding: EdgeInsets.symmetric(horizontal: 21),
      child: ListView.builder(
        itemCount: activeChat.messages.length ?? 0,
        itemBuilder: (context, index) {
          final message = activeChat.messages[index];
          return ChatBubble(
            message: message.text,
            date: message.date,
            correctedMessage: 'Hello',
          );
        },
      ),
    ): Container();
  }
}