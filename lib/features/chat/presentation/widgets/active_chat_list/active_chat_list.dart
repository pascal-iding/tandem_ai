
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './active_chat_entry.dart';
import '../../../data/models/chat_list.dart';
import '../../../logic/cubit/chat_list_cubit.dart';


class ActiveChatList extends StatelessWidget {
  const ActiveChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 69 + 5 + 8 + 16,
      child: BlocBuilder<ChatListCubit, ChatList>(
        builder: (context, chatListState) {
          return Row(
            children: [
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: chatListState.chats.length,
                  itemBuilder: (context, index) {
                    final chat = chatListState.chats[index];
                    final isActive = chatListState.activeChatIndex == index;

                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ActiveChatEntry(
                        chatId: chat.id,
                        profilePicturePath: chat.persona.picturePath,
                        name: chat.persona.name.toName(),
                        isActive: isActive,
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
      )
    );
  }
}
