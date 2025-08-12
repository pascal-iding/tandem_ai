import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tandem_ai/main.dart';
import 'package:tandem_ai/shared/themes/default_theme.dart';

void main() {
  group('MainApp Widget Tests', () {
    testWidgets('MainApp builds without throwing', (WidgetTester tester) async {
      const defaultTheme = DefaultTheme();
      
      await tester.pumpWidget(
        MainApp(defaultTheme: defaultTheme),
      );

      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('MainApp uses correct theme', (WidgetTester tester) async {
      const defaultTheme = DefaultTheme();
      
      await tester.pumpWidget(
        MainApp(defaultTheme: defaultTheme),
      );

      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.theme, equals(defaultTheme.light()));
      expect(materialApp.themeMode, equals(ThemeMode.light));
    });

    testWidgets('MainApp has correct title', (WidgetTester tester) async {
      const defaultTheme = DefaultTheme();
      
      await tester.pumpWidget(
        MainApp(defaultTheme: defaultTheme),
      );

      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.title, equals('Tandem Ai'));
    });

    testWidgets('MainApp has correct supported locales', (WidgetTester tester) async {
      const defaultTheme = DefaultTheme();
      
      await tester.pumpWidget(
        MainApp(defaultTheme: defaultTheme),
      );

      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.supportedLocales, contains(const Locale('en')));
      expect(materialApp.supportedLocales, contains(const Locale('de')));
    });
  });

  group('main function', () {
    test('main function can be called', () {
      expect(main, isA<Function>());
    });
  });
}