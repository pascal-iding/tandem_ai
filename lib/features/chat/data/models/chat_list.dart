import 'dart:math';

import '../constants/message_author.dart';
import '../constants/persona_names.dart';
import './chat_settings.dart';

class ChatList {
  List<Chat> chats;
  // TODO: Use chat id instead
  int? activeChatIndex;

  ChatList({required this.chats, this.activeChatIndex});
}

class Chat {
  static int _idCounter = 0;

  final int id;
  List<Message> messages;
  Persona persona;
  ChatSettings settings;

  Chat({required this.messages, required this.persona, required this.settings})
    : id = _idCounter++;

  @override
  String toString() {
    final StringBuffer buffer = StringBuffer();

    buffer.writeln('Chat ID: $id');
    buffer.writeln('Persona: ${persona.name.name} (${persona.personality})');
    buffer.writeln('Messages (${messages.length}):');
    buffer.writeln('=' * 50);

    for (int i = 0; i < messages.length; i++) {
      final message = messages[i];
      final authorName = message.author == MessageAuthor.user ? 'User' : 'AI';
      final timestamp =
          '${message.date.hour.toString().padLeft(2, '0')}:${message.date.minute.toString().padLeft(2, '0')}';

      buffer.writeln('[$timestamp] $authorName: ${message.text}');

      if (message.feedback != null && message.feedback!.isNotEmpty) {
        buffer.writeln('  └─ Feedback: ${message.feedback}');
      }

      if (i < messages.length - 1) {
        buffer.writeln();
      }
    }

    return buffer.toString();
  }
}

class Persona {
  final PersonaName name;
  final String picturePath;
  final String personality;

  static final List<String> _personalities = [
    "Speaks with enthusiasm and lots of gestures.",
    "Uses short, direct sentences with a calm tone.",
    "Often cracks jokes and keeps the mood light.",
    "Speaks thoughtfully, choosing words with care.",
    "Friendly and supportive, always encouraging others.",
  ];

  static final List<Map<String, String>> _pictures = [
    {"picture": 'assets/images/personas/1.jpg', "gender": "male"},
    {"picture": 'assets/images/personas/2.jpg', "gender": "female"},
  ];

  static final List<PersonaName> _maleNames = [
    PersonaName.kevin,
    PersonaName.john,
    PersonaName.michael,
    PersonaName.david,
    PersonaName.daniel,
    PersonaName.matthew,
    PersonaName.andrew,
    PersonaName.james,
    PersonaName.christopher,
    PersonaName.joshua,
  ];

  static final List<PersonaName> _femaleNames = [
    PersonaName.sara,
    PersonaName.emily,
    PersonaName.jessica,
    PersonaName.emma,
    PersonaName.olivia,
    PersonaName.sophia,
    PersonaName.ava,
    PersonaName.isabella,
    PersonaName.mia,
    PersonaName.charlotte,
  ];

  Persona({
    required this.name,
    required this.picturePath,
    required this.personality,
  });

  static Persona random() {
    final pictureData = _pictures[Random().nextInt(_pictures.length)];
    final String picturePath = pictureData["picture"]!;
    final String gender = pictureData["gender"]!;

    final PersonaName randomName;
    if (gender == "male") {
      randomName = _maleNames[Random().nextInt(_maleNames.length)];
    } else {
      randomName = _femaleNames[Random().nextInt(_femaleNames.length)];
    }

    final String personality =
        _personalities[Random().nextInt(_personalities.length)];

    return Persona(
      name: randomName,
      picturePath: picturePath,
      personality: personality,
    );
  }
}

class Message {
  final MessageAuthor author;
  final String text;
  final String? feedback;
  final DateTime date;

  const Message({
    required this.author,
    required this.text,
    required this.date,
    this.feedback,
  });
}
