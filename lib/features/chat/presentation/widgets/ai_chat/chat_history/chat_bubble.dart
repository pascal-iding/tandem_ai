import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class ChatBubble extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: isUserMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.9,
                ),
                child: Container(
                  padding: EdgeInsets.all(21),
                  decoration: BoxDecoration(
                    color: isUserMessage
                      ? Theme.of(context).colorScheme.surface.withAlpha(150)
                      : Theme.of(context).colorScheme.secondary.withAlpha(150),
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: Text(
                    message,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (correctedMessage != null)
                    Container(
                      width: 23,
                      height: 23,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: isUserMessage
                          ? Theme.of(context).colorScheme.surface.withAlpha(150)
                          : Theme.of(context).colorScheme.secondary.withAlpha(150),
                      ),
                      child: SvgPicture.asset(
                        'assets/icons/info.svg',
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.onSurface,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  if (correctedMessage != null)
                    const SizedBox(width: 5),
                  Container(
                    height: 23,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: isUserMessage
                        ? Theme.of(context).colorScheme.surface.withAlpha(150)
                        : Theme.of(context).colorScheme.secondary.withAlpha(150),
                    ),
                    child: Text(
                      DateFormat('dd.MM.yyyy HH:mm').format(date),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8)
            ],
          ),
        )
      ],
    );
  }
}