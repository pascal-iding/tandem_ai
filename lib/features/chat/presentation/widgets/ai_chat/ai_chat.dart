import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tandem_ai/features/chat/data/models/chat_list.dart';

import 'package:tandem_ai/features/chat/logic/cubit/chat_list_cubit.dart';
import './header.dart';


class AiChat extends StatelessWidget {
  final double maxHeight;

  const AiChat({super.key, required this.maxHeight});

  @override
  Widget build(BuildContext context) {
    final Chat? activeChat = context.read<ChatListCubit>().getActiveChat();

    return Container(
      width: double.infinity,
      height: maxHeight,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/language_backgrounds/spain.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: activeChat != null 
        ? Column(
          children: [
            Header()
          ],
        )
      : null
    );
  }
}