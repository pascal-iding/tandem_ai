
import 'package:flutter/material.dart';

import '../widgets/scroll_indicator.dart';
import '../widgets/chat_settings.dart';
import '../widgets/ai_chat.dart';


class ChatScreen extends StatefulWidget {

  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}


class _ChatScreenState extends State<ChatScreen> {
  late final PageController _controller;
  bool _isScrolling = false;
  bool _isLastPage = false;
  int _currentPage = 0;
  final List<Widget> _pages = [
    ChatSettings(),
    AiChat()
  ];

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 0.9);
    
    _controller.addListener(_onPageChanged);
  }

  void _onPageChanged() {
    final page = _controller.page;
    
    if (page == null) {
      return;
    }

    final currentPage = page.round();
    final isLastPage = currentPage >= _pages.length - 1;
    final isScrolling = (page - currentPage).abs() > 0.01;
    
    if (_currentPage != currentPage || 
        _isLastPage != isLastPage || 
        _isScrolling != isScrolling) {
      setState(() {
        _currentPage = currentPage;
        _isLastPage = isLastPage;
        _isScrolling = isScrolling;
      });
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onPageChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final stackHeight = constraints.maxHeight;
          
          return Stack(
            children: [
              PageView.builder(
                controller: _controller,
                scrollDirection: Axis.vertical,
                padEnds: false,
                physics: const BouncingScrollPhysics(),
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return _pages[index];
                },
              ),
              if (!_isScrolling && !_isLastPage)
                SizedBox(
                  height: 0.9 * stackHeight + 38/2,
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
