import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'dart:ui';

class ChatBubble extends StatefulWidget {
  final String message;
  final DateTime date;
  final String? correctedMessage;
  final bool isUserMessage;

  const ChatBubble({
    super.key,
    required this.message,
    required this.date,
    this.correctedMessage,
    this.isUserMessage = true,
  });

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble>
    with SingleTickerProviderStateMixin {
  bool _showCorrectedMessage = false;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleMessage() {
    if (widget.correctedMessage != null) {
      setState(() {
        _showCorrectedMessage = !_showCorrectedMessage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: widget.isUserMessage
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.9,
                    ),
                    child: GestureDetector(
                      onTap: _toggleMessage,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            padding: EdgeInsets.all(21),
                            decoration: BoxDecoration(
                              color:
                                  (widget.isUserMessage ||
                                      _showCorrectedMessage)
                                  ? Theme.of(
                                      context,
                                    ).colorScheme.surface.withAlpha(170)
                                  : Theme.of(
                                      context,
                                    ).colorScheme.secondary.withAlpha(170),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color:
                                    (widget.isUserMessage ||
                                        _showCorrectedMessage)
                                    ? Theme.of(
                                        context,
                                      ).colorScheme.onSurface.withAlpha(30)
                                    : Theme.of(
                                        context,
                                      ).colorScheme.onSecondary.withAlpha(30),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              _showCorrectedMessage &&
                                      widget.correctedMessage != null
                                  ? widget.correctedMessage!
                                  : widget.message,
                              style:
                                  (widget.isUserMessage ||
                                      _showCorrectedMessage)
                                  ? Theme.of(context).textTheme.bodyMedium
                                  : Theme.of(
                                      context,
                                    ).textTheme.bodyMedium?.copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSecondary,
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: widget.isUserMessage
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      if (widget.correctedMessage != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              width: 23,
                              height: 23,
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: widget.isUserMessage
                                    ? Theme.of(
                                        context,
                                      ).colorScheme.surface.withAlpha(170)
                                    : Theme.of(
                                        context,
                                      ).colorScheme.secondary.withAlpha(170),
                                border: Border.all(
                                  color: widget.isUserMessage
                                      ? Theme.of(
                                          context,
                                        ).colorScheme.onSurface.withAlpha(30)
                                      : Theme.of(
                                          context,
                                        ).colorScheme.onSecondary.withAlpha(30),
                                  width: 1,
                                ),
                              ),
                              child: SvgPicture.asset(
                                'assets/icons/info.svg',
                                colorFilter: ColorFilter.mode(
                                  widget.isUserMessage
                                      ? Theme.of(context).colorScheme.onSurface
                                      : Theme.of(
                                          context,
                                        ).colorScheme.onSecondary,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ),
                        ),
                      if (widget.correctedMessage != null)
                        const SizedBox(width: 5),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            height: 23,
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: widget.isUserMessage
                                  ? Theme.of(
                                      context,
                                    ).colorScheme.surface.withAlpha(170)
                                  : Theme.of(
                                      context,
                                    ).colorScheme.secondary.withAlpha(170),
                              border: Border.all(
                                color: widget.isUserMessage
                                    ? Theme.of(
                                        context,
                                      ).colorScheme.onSurface.withAlpha(30)
                                    : Theme.of(
                                        context,
                                      ).colorScheme.onSecondary.withAlpha(30),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              DateFormat(
                                'dd.MM.yyyy HH:mm',
                              ).format(widget.date),
                              style: widget.isUserMessage
                                  ? Theme.of(context).textTheme.bodySmall
                                  : Theme.of(
                                      context,
                                    ).textTheme.bodySmall?.copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSecondary,
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
