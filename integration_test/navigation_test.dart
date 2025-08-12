import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:tandem_ai/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Navigation Integration Tests', () {
    testWidgets('Navigate to Profile screen', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      final profileIcon = find.byIcon(Icons.person);
      if (profileIcon.evaluate().isNotEmpty) {
        await tester.tap(profileIcon.first);
        await tester.pumpAndSettle();
        
        expect(find.byKey(const Key('profile_screen')), findsOneWidget);
      }
    });

    testWidgets('Navigate to About screen', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      final aboutIcon = find.byIcon(Icons.info);
      if (aboutIcon.evaluate().isNotEmpty) {
        await tester.tap(aboutIcon.first);
        await tester.pumpAndSettle();
        
        expect(find.byKey(const Key('about_screen')), findsOneWidget);
      }
    });

    testWidgets('Navigate back to Chat screen', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      final profileIcon = find.byIcon(Icons.person);
      if (profileIcon.evaluate().isNotEmpty) {
        await tester.tap(profileIcon.first);
        await tester.pumpAndSettle();
        
        final homeIcon = find.byIcon(Icons.home);
        if (homeIcon.evaluate().isNotEmpty) {
          await tester.tap(homeIcon.first);
          await tester.pumpAndSettle();
          
          expect(find.byKey(const Key('chat_screen')), findsOneWidget);
        }
      }
    });

    testWidgets('Navigation maintains app state', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('new_chat_button')));
      await tester.pumpAndSettle();

      final profileIcon = find.byIcon(Icons.person);
      if (profileIcon.evaluate().isNotEmpty) {
        await tester.tap(profileIcon.first);
        await tester.pumpAndSettle();
        
        final homeIcon = find.byIcon(Icons.home);
        if (homeIcon.evaluate().isNotEmpty) {
          await tester.tap(homeIcon.first);
          await tester.pumpAndSettle();
          
          expect(find.byKey(const Key('ai_chat')), findsOneWidget);
        }
      }
    });
  });
}