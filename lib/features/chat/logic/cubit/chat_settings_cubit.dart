import 'package:bloc/bloc.dart';

import '../../data/models/chat_settings.dart';
import '../../data/constants/language_level.dart';
import '../../data/constants/languages.dart';
import '../../data/constants/topics.dart';

class ChatSettingsCubit extends Cubit<ChatSettings> {
  ChatSettingsCubit()
    : super(
        ChatSettings(
          name: 'Jonas',
          topic: Topic.movies,
          language: Language.spanish,
          level: LanguageLevel.b1,
        ),
      );

  void updateName(String name) {
    emit(state.copyWith(name: name));
  }

  void updateTopic(Topic topic) {
    emit(state.copyWith(topic: topic));
  }

  void updateLanguage(Language language) {
    emit(state.copyWith(language: language));
  }

  void updateLevel(LanguageLevel level) {
    emit(state.copyWith(level: level));
  }

  void updateSettings({
    String? name,
    Topic? topic,
    Language? language,
    LanguageLevel? level,
  }) {
    emit(
      state.copyWith(
        name: name,
        topic: topic,
        language: language,
        level: level,
      ),
    );
  }

  void reset() {
    emit(
      ChatSettings(
        name: 'Jonas',
        topic: Topic.movies,
        language: Language.spanish,
        level: LanguageLevel.b1,
      ),
    );
  }
}
