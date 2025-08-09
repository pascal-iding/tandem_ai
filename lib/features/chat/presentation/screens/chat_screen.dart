
import 'package:flutter/material.dart';
import 'dart:async';

import '../widgets/scroll_indicator.dart';
import '../widgets/chat_settings/chat_settings.dart';
import '../widgets/ai_chat.dart';


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

  /// Only show the scroll indicator when the user is not scrolling
  /// and at the top of the page.
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
          
          return Stack(
            children: [
              SingleChildScrollView(
                controller: _scrollController,
                physics: const PageScrollPhysics(),
                child: Column(
                  children: [
                    ChatSettings(
                      maxHeight: stackHeight,
                    ),
                    AiChat(maxHeight: stackHeight)
                  ]
                ),
              ),
              if (_showScrollIndicator)
                SizedBox(
                  height: 0.9 * stackHeight + _scrollIndicatorHeight/2,
                  width: double.infinity,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ScrollIndicator(),
                  )
                )
            ],
          );
        },
      ),
    );
  }
}
