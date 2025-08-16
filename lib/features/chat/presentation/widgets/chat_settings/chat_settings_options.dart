import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tandem_ai/features/chat/data/constants/languages.dart';
import 'package:tandem_ai/features/chat/data/constants/topics.dart';
import 'package:tandem_ai/features/chat/data/models/chat_list.dart';
import 'package:tandem_ai/l10n/app_localizations.dart';

import 'package:tandem_ai/shared/widgets/form_elements/dropdowns/default_dropdown.dart';
import 'package:tandem_ai/shared/widgets/form_elements/dropdowns/searchable_dropdown/searchable_dropdown.dart';
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
                SearchableDropdown(
                  title: AppLocalizations.of(context)!.topicSelection,
                  hint: chatSettings.topic.getName(context),
                  dropdownItems: Topic.getTopicList(context),
                  value: chatSettings.topic.getName(context),
                  onChanged: (topic) =>
                      context.read<ChatSettingsCubit>().updateTopic(
                        topic != null
                            ? Topic.fromString(topic, context)
                            : Topic.fromString(
                                Topic.getdefaultTopic(context),
                                context,
                              ),
                      ),
                ),
                const SizedBox(height: 11),
                SearchableDropdown(
                  title: AppLocalizations.of(context)!.langageSelection,
                  hint: chatSettings.language.getName(context),
                  value: chatSettings.language.getName(context),
                  dropdownItems: Language.getLanguageList(context),
                  onChanged: (language) =>
                      context.read<ChatSettingsCubit>().updateLanguage(
                        language != null
                            ? Language.fromString(language, context)
                            : Language.fromString(
                                Language.getDefaultLanguage(context),
                                context,
                              ),
                      ),
                ),
                const SizedBox(height: 11),
                SearchableDropdown(
                  title: AppLocalizations.of(context)!.levelSelection,
                  hint: chatSettings.level.getName(context),
                  value: chatSettings.level.getName(context),
                  dropdownItems: LanguageLevel.getLevelList(context),
                  onChanged: (level) =>
                      context.read<ChatSettingsCubit>().updateLevel(
                        level != null
                            ? LanguageLevel.fromString(level, context)
                            : LanguageLevel.fromString(
                                LanguageLevel.getDefaultLevel(context),
                                context,
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
