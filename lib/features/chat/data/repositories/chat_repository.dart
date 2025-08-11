import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:tandem_ai/features/chat/data/constants/message_author.dart';
import 'package:tandem_ai/features/chat/data/models/chat_list.dart';
import 'package:tandem_ai/features/chat/data/models/chatbot_answer.dart';
import 'package:tandem_ai/shared/utils/api_key_repository.dart';

class ChatRepository {
  static Future<ChatBotAnswer> getAnswer(Chat chat, String newMessage) async {
    String apiKey = '';
    try {
      ApiKeyRepository apiKeyRepository = ApiKeyRepository();
      apiKey = await apiKeyRepository.getApiKey();
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }

    final String instructions =
        'You are talking to a language learner.'
        'Keep your answer under 70 words (or about 2 sentences).'
        'Do answer in ${chat.settings.language.nameEn}, even if the user talks in another language, except when'
        ' the user asks for help with grammar or vocabulary in another language. Then you may answer in the other language.'
        'But afterwards talk in the actual ${chat.settings.language.nameEn} language again.'
        'Try to start the conversation with an interesting and unique opening question.'
        'Your personality is as following: ${chat.persona.personality}.'
        'Strictly only talk about the topic described. If the user changes the topic, try to immediately get back to the actual topic.'
        'The topic of the conversation is ${chat.settings.topic.nameEn}.'
        'Talk like a friend.'
        'Try using language that is appropriate for a learner with the level ${chat.settings.level.nameEn}';
    final String answerInstructions =
        'The main chatbot reply to the user query in plain text.';
    final String feedbackInstructions =
        'Only when there are mistakes in the original message.'
        'If there are mistakes, show the corrected message.'
        'Do not add any comments, only the corrected message.';

    final updatedMessages = List<Message>.from(chat.messages)
      ..add(
        Message(
          author: MessageAuthor.user,
          text: newMessage,
          date: DateTime.now(),
        ),
      );

    final lastMessages = updatedMessages.length > 15
        ? updatedMessages.sublist(updatedMessages.length - 15)
        : updatedMessages;

    final List<Map<String, String>> apiMessages = lastMessages.map((m) {
      return {
        "role": m.author == MessageAuthor.user ? "user" : "assistant",
        "content": m.text,
      };
    }).toList();

    final url = Uri.parse("https://api.openai.com/v1/chat/completions");

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $apiKey",
      },
      body: jsonEncode({
        "model": "gpt-5-mini",
        "messages": [
          {"role": "system", "content": instructions},
          ...apiMessages,
        ],
        "response_format": {
          "type": "json_schema",
          "json_schema": {
            "name": "chatbot_response",
            "schema": {
              "type": "object",
              "properties": {
                "answer": {"type": "string", "description": answerInstructions},
                "feedback": {
                  "type": ["string", "null"],
                  "description": feedbackInstructions,
                },
              },
              "required": ["answer", "feedback"],
              "additionalProperties": false,
            },
          },
        },
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final content = data["choices"][0]["message"]["content"];
      final parsedJson = jsonDecode(content);

      return ChatBotAnswer(
        text: parsedJson["answer"],
        feedback: parsedJson["feedback"],
      );
    } else {
      throw UnauthorizedException(
        "Failed to get answer: ${response.statusCode} - ${response.body}",
      );
    }
  }
}

class UnauthorizedException implements Exception {
  final String message;
  UnauthorizedException(this.message);

  @override
  String toString() => 'UnauthorizedException: $message';
}
