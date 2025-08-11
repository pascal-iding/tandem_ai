
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tandem_ai/features/chat/data/constants/language_level.dart';
import 'package:tandem_ai/features/chat/data/constants/languages.dart';
import 'package:tandem_ai/features/chat/data/constants/message_author.dart';
import 'package:tandem_ai/features/chat/data/constants/topics.dart';
import 'package:tandem_ai/features/chat/data/models/chat_list.dart';


class ChatBotAnswer {
  final String text;
  final String? feedback;

  ChatBotAnswer({required this.text, this.feedback});
}

class ChatRepository {
  static final String _apiKey = '';
  static Future<ChatBotAnswer> getAnswer(Chat chat, String newMessage) async {
    // return ChatBotAnswer(text: 'Test', feedback: 'Hallo Welt uihde iuhc iwec bidsub ciwdu bcfiwdhb efciwe b');
    final String instructions = 
      'You are talking to a language learner. Strictly only answer in the following language: ${getLanguageNameEn(chat.settings.language)}.'
      'Keep your answer under 70 words (or about 2 sentences).'
      'Do not answer in a different language, even if the user talks in another language, except when'
      ' the user asks a language related question and neeps help, you may answer in the other language.'
      'But afterwards talk in the actual ${getLanguageNameEn(chat.settings.language)} language again.'
      'Try to start the conversation with an interesting and unique opening question.'
      'Your personality is as following: ${chat.persona.personality}.'
      'Strictly only talk about the topic described. If the user changes the topic, try to immediately get back to the actual topic.'
      'The topic of the conversation is ${getTopicNameEn(chat.settings.topic)}.'
      'Talk like a friend.'
      'Try using language that is appropriate for a learner with the level ${getLevelNameEn(chat.settings.level)}'
    ;
    final String answerInstructions = 'The main chatbot reply to the user query in plain text.';
    final String feedbackInstructions = 
      'Only when there are mistakes in the original message.'
      'If there are mistakes, show the corrected message.'
      'Do not add any comments, only the corrected message.'
    ;
    // Add the user's new message to the context
    final updatedMessages = List<Message>.from(chat.messages)
      ..add(Message(
        author: MessageAuthor.user,
        text: newMessage,
        date: DateTime.now(),
      ));

    // Keep only the last 15 messages
    final lastMessages = updatedMessages.length > 15
        ? updatedMessages.sublist(updatedMessages.length - 15)
        : updatedMessages;

    // Map your Message objects to OpenAI API format
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
        "Authorization": "Bearer $_apiKey",
      },
      body: jsonEncode({
        "model": "gpt-5-mini",
        "messages": [
          {
            "role": "system",
            "content": instructions
          },
          ...apiMessages
        ],
        "response_format": {
        "type": "json_schema",
        "json_schema": {
          "name": "chatbot_response",
          "schema": {
            "type": "object",
            "properties": {
              "answer": { 
                "type": "string",
                "description": answerInstructions 
              },
              "feedback": { 
                "type": ["string", "null"],
                "description": feedbackInstructions
              }
            },
            "required": ["answer", "feedback"],
            "additionalProperties": false
          }
        }
      }
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
      throw Exception(
        "Failed to get answer: ${response.statusCode} - ${response.body}",
      );
    }
  }
}
