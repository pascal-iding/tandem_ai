import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tandem_ai/features/about/presentation/screens/about_screen.dart';
import 'package:tandem_ai/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  group('AboutScreen Widget Tests', () {
    Widget createAboutScreen() {
      return MaterialApp(
        home: const AboutScreen(),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('de'),
        ],
      );
    }

    testWidgets('AboutScreen builds without throwing', (WidgetTester tester) async {
      await tester.pumpWidget(createAboutScreen());
      expect(find.byType(AboutScreen), findsOneWidget);
    });

    testWidgets('AboutScreen contains a Scaffold', (WidgetTester tester) async {
      await tester.pumpWidget(createAboutScreen());
      expect(find.byType(Scaffold), findsOneWidget);
    });
  });
}