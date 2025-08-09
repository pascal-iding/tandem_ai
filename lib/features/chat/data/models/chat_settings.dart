
import '../constants/language_level.dart';
import '../constants/languages.dart';
import '../constants/topics.dart';


class ChatSettings {
  final String name;
  final Topic topic;
  final Language language;
  final LanguageLevel level;

  const ChatSettings({
    required this.name,
    required this.topic,
    required this.language,
    required this.level,
  });

  ChatSettings copyWith({
    String? name,
    Topic? topic,
    Language? language,
    LanguageLevel? level,
  }) {
    return ChatSettings(
      name: name ?? this.name,
      topic: topic ?? this.topic,
      language: language ?? this.language,
      level: level ?? this.level,
    );
  }
}
