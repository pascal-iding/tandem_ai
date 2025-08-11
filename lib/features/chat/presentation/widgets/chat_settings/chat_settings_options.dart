
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tandem_ai/features/chat/data/models/chat_list.dart';

import 'package:tandem_ai/shared/widgets/form_elements/dropdowns/default_dropdown.dart';
import '../active_chat_list/active_chat_list.dart';
import '../../../data/constants/languages.dart';
import '../../../logic/cubit/chat_settings_cubit.dart';
import '../../../logic/cubit/chat_list_cubit.dart';
import '../../../data/models/chat_settings.dart';
import '../../../data/constants/language_level.dart';
import '../../../data/constants/topics.dart';


class ChatSettingsOptions extends StatelessWidget {
  ChatSettingsOptions({super.key});

  final TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: BlocBuilder<ChatSettingsCubit, ChatSettings> (
          builder: (context, chatSettings) {
            return Column(
              children: [
                BlocBuilder<ChatListCubit, ChatList> (
                  builder: (context, chatListState) {
                    if (chatListState.chats.isNotEmpty) {
                      return ActiveChatList();
                    }
                    return Container();
                  }
                ),
                const SizedBox(height: 11),
                DefaultDropdown(
                  title: 'Worüber möchtest du reden',
                  hint: getTopicName(chatSettings.topic),
                  dropdownItems: getTopicList(),
                  onChanged: (topic) => context.read<ChatSettingsCubit>().updateTopic(
                    topic != null ? getTopic(topic): getTopic(getDefaultTopic())
                  ),
                ),
                const SizedBox(height: 11),
                DefaultDropdown(
                  title: 'Welche Sprache möchtest du lernen',
                  hint: getLanguageName(chatSettings.language),
                  value: getLanguageName(chatSettings.language),
                  dropdownItems: getLanguageList(),
                  onChanged: (language) => context.read<ChatSettingsCubit>().updateLanguage(
                    language != null ? getLanguage(language): getLanguage(getDefaultLanguage())
                  ),
                ),
                const SizedBox(height: 11),
                DefaultDropdown(
                  title: 'Was ist dein aktuelles Level',
                  hint: getLevelName(chatSettings.level),
                  value: getLevelName(chatSettings.level),
                  dropdownItems: getLevelList(),
                  onChanged: (level) => context.read<ChatSettingsCubit>().updateLevel(
                    level != null ? getLevel(level): getLevel(getDefaultLevel())
                  ),
                ),
                const SizedBox(height: 11)
              ],
            );
          }
        )
      ),
    );
  }
}