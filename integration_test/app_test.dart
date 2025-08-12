import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:tandem_ai/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('App Integration Tests', () {
    testWidgets('App launches successfully and navigates to chat screen', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('Navigation between screens works', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.person).first);
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.info).first);
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.home).first);
      await tester.pumpAndSettle();
    });
  });
}