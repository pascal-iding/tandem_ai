import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tandem_ai/features/chat/data/constants/languages.dart';
import 'package:tandem_ai/features/chat/data/constants/topics.dart';
import 'package:tandem_ai/features/chat/data/models/chat_list.dart';

import 'package:tandem_ai/shared/widgets/form_elements/dropdowns/default_dropdown.dart';
import '../active_chat_list/active_chat_list.dart';
import '../../../logic/cubit/chat_settings_cubit.dart';
import '../../../logic/cubit/chat_list_cubit.dart';
import '../../../data/models/chat_settings.dart';
import '../../../data/constants/language_level.dart';

class ChatSettingsOptions extends StatelessWidget {
  ChatSettingsOptions({super.key});

  final TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: BlocBuilder<ChatSettingsCubit, ChatSettings>(
          builder: (context, chatSettings) {
            return Column(
              children: [
                BlocBuilder<ChatListCubit, ChatList>(
                  builder: (context, chatListState) {
                    if (chatListState.chats.isNotEmpty) {
                      return ActiveChatList();
                    }
                    return Container();
                  },
                ),
                const SizedBox(height: 11),
                DefaultDropdown(
                  title: 'Worüber möchtest du reden',
                  hint: chatSettings.topic.name,
                  dropdownItems: Topic.topicList,
                  onChanged: (topic) =>
                      context.read<ChatSettingsCubit>().updateTopic(
                        topic != null
                            ? Topic.fromString(topic)
                            : Topic.fromString(Topic.defaultTopic),
                      ),
                ),
                const SizedBox(height: 11),
                DefaultDropdown(
                  title: 'Welche Sprache möchtest du lernen',
                  hint: chatSettings.language.name,
                  value: chatSettings.language.name,
                  dropdownItems: Language.languageList,
                  onChanged: (language) =>
                      context.read<ChatSettingsCubit>().updateLanguage(
                        language != null
                            ? Language.fromString(language)
                            : Language.fromString(Language.defaultLanguage),
                      ),
                ),
                const SizedBox(height: 11),
                DefaultDropdown(
                  title: 'Was ist dein aktuelles Level',
                  hint: chatSettings.level.name,
                  value: chatSettings.level.name,
                  dropdownItems: LanguageLevel.levelList,
                  onChanged: (level) =>
                      context.read<ChatSettingsCubit>().updateLevel(
                        level != null
                            ? LanguageLevel.fromString(level)
                            : LanguageLevel.fromString(
                                LanguageLevel.defaultLevel,
                              ),
                      ),
                ),
                const SizedBox(height: 11),
              ],
            );
          },
        ),
      ),
    );
  }
}
