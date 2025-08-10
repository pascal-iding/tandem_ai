
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tandem_ai/features/chat/data/models/chat_list.dart';

import '../../../logic/cubit/chat_list_cubit.dart';
import '../../../logic/cubit/chat_settings_cubit.dart';
import './active_indicator.dart';


class ActiveChatEntry extends StatefulWidget {
  final int chatId;
  final String profilePicturePath;
  final String name;
  final bool isActive;

  const ActiveChatEntry({
    super.key, 
    required this.chatId,
    required this.profilePicturePath, 
    required this.name, 
    this.isActive = false
  });

  @override
  State<ActiveChatEntry> createState() => _ActiveChatEntryState();
}

class _ActiveChatEntryState extends State<ActiveChatEntry>
    with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;
  bool _isScaled = false;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.3,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  void _handleDeleteTap() {
    if (!_isScaled) {
      setState(() {
        _isScaled = true;
      });
      _scaleController.forward();
      
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted && _isScaled) {
          setState(() {
            _isScaled = false;
          });
          _scaleController.reverse();
        }
      });
    } else {
      context.read<ChatListCubit>().removeChat(widget.chatId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<ChatListCubit>().setActiveChat(widget.chatId);
        Chat? chat = context.read<ChatListCubit>().getChat(widget.chatId);
        if (chat == null) return;
        context.read<ChatSettingsCubit>().updateSettings(
          name: chat.settings.name,
          topic: chat.settings.topic,
          language: chat.settings.language,
          level: chat.settings.level
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: 69,
                height: 69,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage(widget.profilePicturePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                right: 5,
                top: 5,
                child: GestureDetector(
                  onTap: _handleDeleteTap,
                  child: AnimatedBuilder(
                    animation: _scaleAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _scaleAnimation.value,
                        child: Container(
                          width: 21,
                          height: 21,
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _isScaled 
                              ? Theme.of(context).colorScheme.error
                              : Theme.of(context).colorScheme.primary,
                          ),
                          child: SvgPicture.asset(
                            'assets/icons/x.svg',
                            colorFilter: ColorFilter.mode(
                              Theme.of(context).colorScheme.onPrimary,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              if (widget.isActive)
                Positioned(
                  right: 5,
                  bottom: 5,
                  child: ActiveIndicator()
                )
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 69,
            child: Text(
              widget.name,
              style: Theme.of(context).textTheme.bodyMedium,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}
