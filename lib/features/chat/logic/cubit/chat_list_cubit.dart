
import 'package:bloc/bloc.dart';

import '../../data/models/chat_list.dart';
import '../../data/models/chat_settings.dart';


class ChatListCubit extends Cubit<ChatList> {
  ChatListCubit() : super(ChatList(chats: []));

  void addChat(ChatSettings settings) {
    Persona randomPersona = Persona.random();
    final newChat = Chat(
      messages: [], 
      persona: randomPersona, 
      settings: settings,
    );

    final updatedChats = [newChat, ...state.chats];
    emit(ChatList(chats: updatedChats)..activeChatIndex = 0);
  }

  void removeChat(int chatId) {
    final index = state.chats.indexWhere((chat) => chat.id == chatId);
    if (index == -1) return;

    final updated = List<Chat>.from(state.chats)..removeAt(index);

    int? newActiveIndex;
    if (updated.isNotEmpty) {
      newActiveIndex = 0;
    } else {
      newActiveIndex = null;
    }

    emit(ChatList(chats: updated, activeChatIndex: newActiveIndex));
  }

  void setActiveChat(int chatId) {
    final index = state.chats.indexWhere((chat) => chat.id == chatId);
    if (index == -1) return; 

    emit(ChatList(
      chats: state.chats,
      activeChatIndex: index
    ));
  }

  Chat? getChat(int chatId) {
    final index = state.chats.indexWhere((chat) => chat.id == chatId);
    if (index == -1) return null; 
    return state.chats[index];
  }

  Chat? getActiveChat() {
    if (state.activeChatIndex == null) return null;
    return state.chats[state.activeChatIndex!];
  }

  void addMessage(int chatIndex, Message message) {
    if (chatIndex < 0 || chatIndex >= state.chats.length) return;
    final updatedChats = List<Chat>.from(state.chats);
    final updatedChat = updatedChats[chatIndex];
    updatedChats[chatIndex] = Chat(
      messages: [...updatedChat.messages, message],
      persona: updatedChat.persona,
      settings: state.chats[chatIndex].settings,
    );
    emit(ChatList(chats: updatedChats));
  }

  void clearChats() {
    emit(ChatList(chats: []));
  }
}
