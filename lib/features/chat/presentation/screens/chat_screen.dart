import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/scroll_indicator.dart';
import '../widgets/chat_settings/chat_settings.dart';
import '../widgets/ai_chat/ai_chat.dart';
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
  double _scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!mounted) return;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _scrollOffset = _scrollController.offset;
        });
      }
    });
  }

  void _onScrollStart() {
    if (!mounted) return;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _showScrollIndicator = false;
        });
      }
    });
  }

  void _onScrollEnd() {
    if (!mounted) return;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _showScrollIndicator = _isAtTop();
        });
      }
    });
  }

  bool _isAtTop() {
    if (!_scrollController.hasClients) return true;
    return _scrollController.offset <= 0.0;
  }

  void _scrollToBottom() {
    if (!_scrollController.hasClients) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final stackHeight = constraints.maxHeight;

          return MultiBlocProvider(
            providers: [
              BlocProvider<ChatSettingsCubit>(
                create: (context) => ChatSettingsCubit(),
              ),
              BlocProvider<ChatListCubit>(create: (context) => ChatListCubit()),
            ],
            child: BlocBuilder<ChatListCubit, ChatList>(
              builder: (context, chatListState) {
                final hasChats =
                    chatListState.chats.isNotEmpty &&
                    chatListState.activeChatIndex != null;

                if (!hasChats && _scrollController.hasClients) {
                  _scrollController.jumpTo(0);
                }

                return NotificationListener<ScrollNotification>(
                  onNotification: (notification) {
                    if (notification is ScrollStartNotification) {
                      _onScrollStart();
                    } else if (notification is ScrollEndNotification) {
                      _onScrollEnd();
                    }
                    return false;
                  },
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        controller: _scrollController,
                        physics: hasChats
                            ? const PageScrollPhysics()
                            : const NeverScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            ChatSettings(
                              maxHeight: stackHeight,
                              onNewChat: _scrollToBottom,
                            ),
                            AiChat(
                              maxHeight: stackHeight,
                              scrollOffset: _scrollOffset,
                            ),
                          ],
                        ),
                      ),
                      if (_showScrollIndicator && hasChats)
                        SizedBox(
                          height:
                              0.9 * stackHeight + _scrollIndicatorHeight / 2,
                          width: double.infinity,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: ScrollIndicator(),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
