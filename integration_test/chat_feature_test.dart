import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:tandem_ai/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Chat Feature Integration Tests', () {
    testWidgets('Chat screen loads and displays settings', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('chat_settings')), findsOneWidget);
      expect(find.byKey(const Key('language_dropdown')), findsOneWidget);
      expect(find.byKey(const Key('level_dropdown')), findsOneWidget);
      expect(find.byKey(const Key('topic_dropdown')), findsOneWidget);
    });

    testWidgets('User can interact with dropdowns', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('language_dropdown')));
      await tester.pumpAndSettle();
      
      expect(find.text('English'), findsWidgets);
      expect(find.text('German'), findsWidgets);
      
      await tester.tap(find.text('German').first);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('level_dropdown')));
      await tester.pumpAndSettle();
      
      await tester.tap(find.text('Beginner').first);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('topic_dropdown')));
      await tester.pumpAndSettle();
      
      await tester.tap(find.text('Food & Cooking').first);
      await tester.pumpAndSettle();
    });

    testWidgets('User can start a new chat', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('new_chat_button')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('ai_chat')), findsOneWidget);
      expect(find.byKey(const Key('chat_history')), findsOneWidget);
    });

    testWidgets('User can type a message', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('new_chat_button')));
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(const Key('message_input')), 'Hello, how are you?');
      await tester.pumpAndSettle();

      expect(find.text('Hello, how are you?'), findsOneWidget);
    });

    testWidgets('Send button is enabled when message is entered', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('new_chat_button')));
      await tester.pumpAndSettle();

      final sendButton = find.byKey(const Key('send_button'));
      expect(sendButton, findsOneWidget);

      await tester.enterText(find.byKey(const Key('message_input')), 'Test message');
      await tester.pumpAndSettle();

      await tester.tap(sendButton);
      await tester.pumpAndSettle();
    });

    testWidgets('Chat history displays messages', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('new_chat_button')));
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(const Key('message_input')), 'Integration test message');
      await tester.tap(find.byKey(const Key('send_button')));
      await tester.pumpAndSettle();

      expect(find.text('Integration test message'), findsOneWidget);
    });

    testWidgets('Multiple chats can be created', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('new_chat_button')));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('new_chat_button')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('active_chat_list')), findsOneWidget);
    });
  });
}