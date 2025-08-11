import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:tandem_ai/shared/themes/default_theme.dart';
import 'routes/app_router.dart';

void main() async {
  const defaultTheme = DefaultTheme();

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(MainApp(defaultTheme: defaultTheme));
}

class MainApp extends StatefulWidget {
  final DefaultTheme defaultTheme;

  const MainApp({super.key, required this.defaultTheme});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Tandem Ai',
      theme: widget.defaultTheme.light(),
      themeMode: ThemeMode.light,
      routerConfig: appRouter,
    );
  }
}
