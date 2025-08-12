import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tandem_ai/features/chat/data/constants/message_author.dart';
import 'package:tandem_ai/features/chat/data/constants/languages.dart';
import 'package:tandem_ai/features/chat/data/constants/language_level.dart';
import 'package:tandem_ai/features/chat/data/constants/topics.dart';
import 'package:tandem_ai/features/chat/data/models/chat_list.dart';
import 'package:tandem_ai/features/chat/data/models/chat_settings.dart';
import 'package:tandem_ai/features/chat/logic/cubit/chat_list_cubit.dart';

void main() {
  group('ChatListCubit', () {
    late ChatListCubit chatListCubit;
    late ChatSettings testChatSettings;

    setUp(() {
      chatListCubit = ChatListCubit();
      testChatSettings = ChatSettings(
        name: 'Test Chat',
        language: Language.english,
        level: LanguageLevel.a1,
        topic: Topic.leisure,
      );
    });

    tearDown(() {
      chatListCubit.close();
    });

    test('initial state is empty chat list', () {
      expect(chatListCubit.state.chats, isEmpty);
      expect(chatListCubit.state.activeChatIndex, isNull);
    });

    blocTest<ChatListCubit, ChatList>(
      'addChat creates new chat and sets it as active',
      build: () => chatListCubit,
      act: (cubit) => cubit.addChat(testChatSettings),
      expect: () => [
        predicate<ChatList>((state) =>
            state.chats.length == 1 &&
            state.activeChatIndex == 0 &&
            state.chats.first.settings == testChatSettings),
      ],
    );

    blocTest<ChatListCubit, ChatList>(
      'addChat adds multiple chats correctly',
      build: () => chatListCubit,
      act: (cubit) {
        cubit.addChat(testChatSettings);
        cubit.addChat(testChatSettings);
      },
      expect: () => [
        predicate<ChatList>((state) =>
            state.chats.length == 1 && state.activeChatIndex == 0),
        predicate<ChatList>((state) =>
            state.chats.length == 2 && state.activeChatIndex == 0),
      ],
    );

    blocTest<ChatListCubit, ChatList>(
      'removeChat removes chat by id',
      build: () => chatListCubit,
      seed: () {
        final chat1 = Chat(
          messages: [],
          persona: Persona.random(),
          settings: testChatSettings,
        );
        final chat2 = Chat(
          messages: [],
          persona: Persona.random(),
          settings: testChatSettings,
        );
        return ChatList(chats: [chat1, chat2], activeChatIndex: 0);
      },
      act: (cubit) => cubit.removeChat(cubit.state.chats.first.id),
      expect: () => [
        predicate<ChatList>((state) =>
            state.chats.length == 1 && state.activeChatIndex == 0),
      ],
    );

    blocTest<ChatListCubit, ChatList>(
      'removeChat sets activeChatIndex to null when removing last chat',
      build: () => chatListCubit,
      seed: () {
        final chat = Chat(
          messages: [],
          persona: Persona.random(),
          settings: testChatSettings,
        );
        return ChatList(chats: [chat], activeChatIndex: 0);
      },
      act: (cubit) => cubit.removeChat(cubit.state.chats.first.id),
      expect: () => [
        predicate<ChatList>((state) =>
            state.chats.isEmpty && state.activeChatIndex == null),
      ],
    );

    blocTest<ChatListCubit, ChatList>(
      'setActiveChat updates active chat index',
      build: () => chatListCubit,
      seed: () {
        final chat1 = Chat(
          messages: [],
          persona: Persona.random(),
          settings: testChatSettings,
        );
        final chat2 = Chat(
          messages: [],
          persona: Persona.random(),
          settings: testChatSettings,
        );
        return ChatList(chats: [chat1, chat2], activeChatIndex: 0);
      },
      act: (cubit) => cubit.setActiveChat(cubit.state.chats[1].id),
      expect: () => [
        predicate<ChatList>((state) => state.activeChatIndex == 1),
      ],
    );

    test('getChat returns correct chat by id', () {
      final chat = Chat(
        messages: [],
        persona: Persona.random(),
        settings: testChatSettings,
      );
      chatListCubit.emit(ChatList(chats: [chat]));

      final result = chatListCubit.getChat(chat.id);
      expect(result, equals(chat));
    });

    test('getChat returns null for non-existent id', () {
      final result = chatListCubit.getChat(999);
      expect(result, isNull);
    });

    test('getActiveChat returns active chat when set', () {
      final chat = Chat(
        messages: [],
        persona: Persona.random(),
        settings: testChatSettings,
      );
      chatListCubit.emit(ChatList(chats: [chat], activeChatIndex: 0));

      final result = chatListCubit.getActiveChat();
      expect(result, equals(chat));
    });

    test('getActiveChat returns null when no active chat', () {
      final result = chatListCubit.getActiveChat();
      expect(result, isNull);
    });

    blocTest<ChatListCubit, ChatList>(
      'addMessages adds messages to existing chat',
      build: () => chatListCubit,
      seed: () {
        final chat = Chat(
          messages: [],
          persona: Persona.random(),
          settings: testChatSettings,
        );
        return ChatList(chats: [chat], activeChatIndex: 0);
      },
      act: (cubit) {
        final messages = [
          Message(
            author: MessageAuthor.user,
            text: 'Hello',
            date: DateTime.now(),
          ),
        ];
        cubit.addMessages(cubit.state.chats.first.id, messages);
      },
      expect: () => [
        predicate<ChatList>((state) =>
            state.chats.first.messages.length == 1 &&
            state.chats.first.messages.first.text == 'Hello'),
      ],
    );

    blocTest<ChatListCubit, ChatList>(
      'clearChats removes all chats',
      build: () => chatListCubit,
      seed: () {
        final chat = Chat(
          messages: [],
          persona: Persona.random(),
          settings: testChatSettings,
        );
        return ChatList(chats: [chat], activeChatIndex: 0);
      },
      act: (cubit) => cubit.clearChats(),
      expect: () => [
        predicate<ChatList>((state) =>
            state.chats.isEmpty && state.activeChatIndex == null),
      ],
    );
  });
}