import 'package:flutter_test/flutter_test.dart';
import 'package:tandem_ai/features/chat/data/constants/message_author.dart';
import 'package:tandem_ai/features/chat/data/constants/languages.dart';
import 'package:tandem_ai/features/chat/data/constants/language_level.dart';
import 'package:tandem_ai/features/chat/data/constants/topics.dart';
import 'package:tandem_ai/features/chat/data/constants/persona_names.dart';
import 'package:tandem_ai/features/chat/data/models/chat_list.dart';
import 'package:tandem_ai/features/chat/data/models/chat_settings.dart';

void main() {
  group('ChatList', () {
    test('can be instantiated with empty chats list', () {
      final chatList = ChatList(chats: []);
      expect(chatList.chats, isEmpty);
      expect(chatList.activeChatIndex, isNull);
    });

    test('can be instantiated with chats and active index', () {
      final chat = Chat(
        messages: [],
        persona: Persona(
          name: PersonaName.sara,
          picturePath: 'assets/images/personas/1.jpg',
          personality: 'Test personality',
        ),
        settings: ChatSettings(
          name: 'Test Chat',
          language: Language.english,
          level: LanguageLevel.a1,
          topic: Topic.movies,
        ),
      );
      final chatList = ChatList(chats: [chat], activeChatIndex: 0);
      expect(chatList.chats.length, equals(1));
      expect(chatList.activeChatIndex, equals(0));
    });
  });

  group('Chat', () {
    test('generates unique IDs for different chats', () {
      final chat1 = Chat(
        messages: [],
        persona: Persona(
          name: PersonaName.sara,
          picturePath: 'assets/images/personas/1.jpg',
          personality: 'Test personality 1',
        ),
        settings: ChatSettings(
          name: 'Test Chat',
          language: Language.english,
          level: LanguageLevel.a1,
          topic: Topic.movies,
        ),
      );
      final chat2 = Chat(
        messages: [],
        persona: Persona(
          name: PersonaName.kevin,
          picturePath: 'assets/images/personas/2.jpg',
          personality: 'Test personality 2',
        ),
        settings: ChatSettings(
          name: 'Test Chat',
          language: Language.english,
          level: LanguageLevel.a1,
          topic: Topic.movies,
        ),
      );

      expect(chat1.id, isNot(equals(chat2.id)));
    });

    test('toString produces formatted output', () {
      final persona = Persona(
        name: PersonaName.sara,
        picturePath: 'assets/images/personas/1.jpg',
        personality: 'Test personality',
      );
      final chat = Chat(
        messages: [
          Message(
            author: MessageAuthor.user,
            text: 'Hello',
            date: DateTime(2023, 1, 1, 12, 30),
          ),
        ],
        persona: persona,
        settings: ChatSettings(
          name: 'Test Chat',
          language: Language.english,
          level: LanguageLevel.a1,
          topic: Topic.movies,
        ),
      );

      final output = chat.toString();
      expect(output, contains('Chat ID:'));
      expect(output, contains('Persona:'));
      expect(output, contains('Messages (1):'));
      expect(output, contains('Hello'));
    });
  });

  group('Persona', () {
    test('random generates persona with all required fields', () {
      final persona = Persona.random();
      expect(persona.name, isNotNull);
      expect(persona.picturePath, isNotNull);
      expect(persona.personality, isNotNull);
      expect(persona.picturePath, startsWith('assets/images/personas/'));
    });

    test('randomUnique generates different personas when possible', () {
      final persona1 = Persona.random();
      final persona2 = Persona.randomUnique([persona1]);
      
      expect(persona2.name, isNot(equals(persona1.name)));
    });

    test('randomUnique falls back to random when no unique options', () {
      final allPersonas = List.generate(20, (_) => Persona.random());
      final newPersona = Persona.randomUnique(allPersonas);
      
      expect(newPersona, isNotNull);
      expect(newPersona.name, isNotNull);
    });
  });

  group('Message', () {
    test('can be created with required fields', () {
      final message = Message(
        author: MessageAuthor.user,
        text: 'Hello World',
        date: DateTime.now(),
      );

      expect(message.author, equals(MessageAuthor.user));
      expect(message.text, equals('Hello World'));
      expect(message.feedback, isNull);
      expect(message.date, isNotNull);
    });

    test('can be created with feedback', () {
      final message = Message(
        author: MessageAuthor.ai,
        text: 'Hello!',
        date: DateTime.now(),
        feedback: 'Great response!',
      );

      expect(message.feedback, equals('Great response!'));
    });
  });
}