import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './active_chat_entry.dart';
import '../../../data/models/chat_list.dart';
import '../../../logic/cubit/chat_list_cubit.dart';

class ActiveChatList extends StatefulWidget {
  const ActiveChatList({super.key});

  @override
  State<ActiveChatList> createState() => _ActiveChatListState();
}

class _ActiveChatListState extends State<ActiveChatList>
    with SingleTickerProviderStateMixin {
  int? _previousChatsLength;
  bool _shouldAnimateFirst = false;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(-1.0, 0.0), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _animateNewFirstElement() {
    setState(() {
      _shouldAnimateFirst = true;
    });
    _animationController.reset();
    _animationController.forward().then((_) {
      setState(() {
        _shouldAnimateFirst = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 69 + 5 + 8 + 16,
      child: BlocListener<ChatListCubit, ChatList>(
        listener: (context, state) {
          if (_previousChatsLength == null ||
              state.chats.length > _previousChatsLength!) {
            _animateNewFirstElement();
          }
          _previousChatsLength = state.chats.length;
        },
        child: BlocBuilder<ChatListCubit, ChatList>(
          builder: (context, chatListState) {
            if (chatListState.chats.isEmpty) {
              return const SizedBox.shrink();
            }

            return Row(
              children: [
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: chatListState.chats.length,
                    itemBuilder: (context, index) {
                      final chat = chatListState.chats[index];
                      final isActive = chatListState.activeChatIndex == index;
                      final isFirstElement = index == 0;

                      Widget chatEntry = Padding(
                        key: ValueKey(chat.id),
                        padding: const EdgeInsets.only(right: 8),
                        child: ActiveChatEntry(
                          chatId: chat.id,
                          profilePicturePath: chat.persona.picturePath,
                          name: chat.persona.name.toName(),
                          isActive: isActive,
                        ),
                      );

                      if (isFirstElement && _shouldAnimateFirst) {
                        return SlideTransition(
                          position: _slideAnimation,
                          child: FadeTransition(
                            opacity: _fadeAnimation,
                            child: chatEntry,
                          ),
                        );
                      }
                      return chatEntry;
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
