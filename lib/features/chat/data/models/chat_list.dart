
import 'dart:math';

import '../constants/message_author.dart';
import '../constants/persona_names.dart';
import './chat_settings.dart';


class ChatList {
  List<Chat> chats;
  int? activeChatIndex;

  ChatList({
    required this.chats,
    this.activeChatIndex
  });

  void setActiveChatByIndex(int index) {
    if (index >= 0 && index < chats.length) {
      activeChatIndex = index;
      return;
    }
    throw Exception('Invalid index!');
  }

  bool isActiveChat(Chat chat) {
    if (activeChatIndex == null) return false;
    return chats[activeChatIndex!] == chat;
  }
}

class Chat {
  static int _idCounter = 0;

  final int id;
  List<Message> messages;
  Persona persona;
  ChatSettings settings;

  Chat({
    required this.messages,
    required this.persona,
    required this.settings
  }) : id = _idCounter++;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Chat &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
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
    "Friendly and supportive, always encouraging others."
  ];

  static final List<String> _pictures = [
    'assets/images/personas/1.jpg',
    'assets/images/personas/2.jpg',
  ];

  Persona({
    required this.name,
    required this.picturePath,
    required this.personality,
  });

  static Persona random() {
    final randomName =
        PersonaName.values[Random().nextInt(PersonaName.values.length)];
    final String personality = _personalities[Random().nextInt(_personalities.length)];
    final String picturePath = _pictures[Random().nextInt(_pictures.length)];
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