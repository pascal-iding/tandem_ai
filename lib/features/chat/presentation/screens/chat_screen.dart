
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/scroll_indicator.dart';
import '../widgets/chat_settings/chat_settings.dart';
import '../widgets/ai_chat.dart';
import '../../logic/cubit/chat_settings_cubit.dart';
import '../../logic/cubit/chat_list_cubit.dart';
import '../../data/models/chat_list.dart';


class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}


class _ChatScreenState extends State<ChatScreen> {
  final ScrollController _scrollController = ScrollController();
  final double _scrollIndicatorHeight = 38;
  bool _showScrollIndicator = true;
  Timer? _scrollTimer;
  bool _isScrolling = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _scrollTimer?.cancel();
    super.dispose();
  }

  void _scrollListener() {
    _scrollTimer?.cancel();
    
    if (!_isScrolling) {
      _onScrollStart();
    }
    
    _scrollTimer = Timer(const Duration(milliseconds: 100), () {
      _onScrollEnd();
    });
  }

  void _onScrollStart() {
    setState(() {
      _isScrolling = true;
      _showScrollIndicator = false;
    });
  }

  void _onScrollEnd() {
    setState(() {
      _isScrolling = false;
      _showScrollIndicator = _isAtTop();
    });
  }

  bool _isAtTop() {
    if (!_scrollController.hasClients) return true;
    
    return _scrollController.offset <= 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final stackHeight = constraints.maxHeight;

          return MultiBlocProvider(
            providers: [
              BlocProvider<ChatSettingsCubit>(
                create: (context) => ChatSettingsCubit(),
              ),
              BlocProvider<ChatListCubit>(
                create: (context) => ChatListCubit(),
              ),
            ],
            child: BlocBuilder<ChatListCubit, ChatList>(
              builder: (context, chatListState) {
                final hasChats = 
                  (chatListState.chats.isNotEmpty) && 
                  (chatListState.activeChatIndex != null);

                if (!hasChats && _scrollController.hasClients) {
                  _scrollController.jumpTo(0);
                }

                return Stack(
                  children: [
                    SingleChildScrollView(
                      controller: _scrollController,
                      physics: hasChats
                          ? const PageScrollPhysics()
                          : const NeverScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          ChatSettings(maxHeight: stackHeight),
                          AiChat(maxHeight: stackHeight),
                        ],
                      ),
                    ),
                    if (_showScrollIndicator && hasChats)
                      SizedBox(
                        height: 0.9 * stackHeight + _scrollIndicatorHeight / 2,
                        width: double.infinity,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: ScrollIndicator(),
                        ),
                      ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
