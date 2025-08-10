
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tandem_ai/features/chat/data/models/chat_list.dart';
import 'package:tandem_ai/features/chat/logic/cubit/chat_list_cubit.dart';
import 'package:tandem_ai/features/chat/presentation/widgets/active_chat_list/active_indicator.dart';


class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    final Chat? activeChat = context.read<ChatListCubit>().getActiveChat();

    final EdgeInsets padding = MediaQuery.of(context).padding;
    final double topSafeArea = padding.top;

    return activeChat != null ? Container(
      padding: EdgeInsets.only(top: topSafeArea + 21, left: 21, right: 21, bottom: 21),
      color: Theme.of(context).colorScheme.surface.withAlpha(100),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: 69,
            height: 69,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(activeChat.persona.picturePath),
                fit: BoxFit.cover
              )
            ),
          ),
          const SizedBox(width: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    activeChat.persona.name.toName(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(width: 8),
                  ActiveIndicator()
                ],
              ),
              Text(
                'From ${activeChat.settings.getCityOfOrigin()}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant
                ),
              )
            ],
          )
        ],
      )
    ): Container();
  }
}