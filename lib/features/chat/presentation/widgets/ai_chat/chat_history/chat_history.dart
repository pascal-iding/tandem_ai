import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tandem_ai/features/chat/data/constants/message_author.dart';

import 'package:tandem_ai/features/chat/data/models/chat_list.dart';
import 'package:tandem_ai/features/chat/logic/cubit/chat_list_cubit.dart';
import 'chat_bubble.dart';

class ChatHistory extends StatefulWidget {
  const ChatHistory({super.key});

  @override
  State<ChatHistory> createState() => _ChatHistoryState();
}

class _ChatHistoryState extends State<ChatHistory> {
  final ScrollController _scrollController = ScrollController();
  int _previousMessageCount = 0;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Chat? activeChat = context.watch<ChatListCubit>().getActiveChat();

    // Only scroll to bottom when new messages are added
    if (activeChat != null && activeChat.messages.length > _previousMessageCount) {
      _previousMessageCount = activeChat.messages.length;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        scrollToBottom();
      });
    }

    return activeChat != null ? Padding(
      padding: const EdgeInsets.symmetric(horizontal: 21),
      child: ListView.builder(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        itemCount: activeChat.messages.length,
        itemBuilder: (context, index) {
          final message = activeChat.messages[index];
          return ChatBubble(
            message: message.text,
            date: message.date,
            isUserMessage: message.author == MessageAuthor.user,
            correctedMessage: message.feedback,
          );
        },
      ),
    ) : Container();
  }
}