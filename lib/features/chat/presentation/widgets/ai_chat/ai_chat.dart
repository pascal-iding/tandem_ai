import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tandem_ai/features/chat/data/constants/message_author.dart';
import 'package:tandem_ai/features/chat/data/models/chat_list.dart';

import 'package:tandem_ai/features/chat/logic/cubit/chat_list_cubit.dart';
import 'package:tandem_ai/features/chat/presentation/widgets/ai_chat/chat_history/chat_history.dart';
import './header.dart';
import 'package:tandem_ai/shared/widgets/form_elements/text_inputs/default_text_area.dart';

class AiChat extends StatefulWidget {
  final double maxHeight;
  final double scrollOffset;

  const AiChat({
    super.key, 
    required this.maxHeight, 
    required this.scrollOffset,
  });

  @override
  State<AiChat> createState() => _AiChatState();
}

class _AiChatState extends State<AiChat> {
  late TextEditingController _textController;
  
  // Adjust these values to control the fade behavior
  static const double _fadeStartOffset = 0.0;
  static const double _fadeEndOffset = 200.0;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  double _calculateHeaderOpacity() {
    if (widget.scrollOffset <= _fadeStartOffset) {
      return 0.0; // Fully transparent at the top
    } else if (widget.scrollOffset >= _fadeEndOffset) {
      return 1.0; // Fully opaque after scrolling enough
    } else {
      // Linear interpolation between 0 and 1
      return (widget.scrollOffset - _fadeStartOffset) / 
             (_fadeEndOffset - _fadeStartOffset);
    }
  }

  void onSend() {
    final Chat? activeChat = context.read<ChatListCubit>().getActiveChat();
    Message message = Message(
      author: MessageAuthor.user, 
      text: _textController.text, 
      date: DateTime.now(),
    );

    if (activeChat == null) return;
    
    context.read<ChatListCubit>().addMessage(activeChat.id, message);
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final Chat? activeChat = context.read<ChatListCubit>().getActiveChat();
    final EdgeInsets padding = MediaQuery.of(context).padding;
    final double headerOpacity = _calculateHeaderOpacity();

    return Container(
      width: double.infinity,
      height: widget.maxHeight,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/language_backgrounds/spain.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: activeChat != null 
        ? Column(
          children: [
            Opacity(
              opacity: headerOpacity,
              child: Header(),
            ),
            const SizedBox(height: 11),
            Expanded(
              child: ChatHistory(),
            ),
            const SizedBox(height: 11),
            Padding(
              padding: EdgeInsets.only(
                left: 21, 
                right: 21, 
                bottom: padding.bottom + 21,
              ),
              child: DefaultTextArea(
                hint: 'Deine Nachricht ...', 
                controller: _textController,
                onSend: () { onSend(); },
              ),
            ),
          ],
        )
      : null,
    );
  }
}
