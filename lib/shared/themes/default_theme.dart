
import "package:flutter/material.dart";


class DefaultTheme {
  
  const DefaultTheme();

  ColorScheme colorSchemeLight() => const ColorScheme(
    primary: Color.fromARGB(255, 0, 0, 0),
    secondary: Color.fromARGB(255, 92, 58, 81),
    surface: Color.fromARGB(255, 255, 255, 255),
    surfaceContainer: Color.fromARGB(255, 255, 255, 255),
    secondaryContainer: Color.fromARGB(255, 193, 182, 189),
    error: Color.fromARGB(255, 235, 93, 93),
    onError: Color.fromARGB(255, 255, 255, 255),
    onPrimary: Color.fromARGB(255, 255, 255, 255),
    onSecondary: Color.fromARGB(255, 0, 0, 0),
    onSurface: Color.fromARGB(255, 0, 0, 0),
    onSurfaceVariant: Color.fromARGB(255, 116, 116, 116),
    outline: Color.fromARGB(255, 0, 0, 0),
    brightness: Brightness.light,
  );

  ColorScheme colorSchemeDark() => throw UnimplementedError();

  TextTheme textTheme(ColorScheme colorScheme) => TextTheme(
    titleMedium: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.w500,
      fontFamily: 'Instrument-Serif',
      color: colorScheme.onSurface,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      fontFamily: 'Inter',
      color: colorScheme.onSurface,
    ),
    // Hint text
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      fontFamily: 'Inter',
      color: colorScheme.onSurface,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      fontFamily: 'Inter',
      color: colorScheme.onSurfaceVariant,
    ),
    labelLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      fontFamily: 'Instrument-Serif',
      color: colorScheme.onSurface,
    ),
  );

  ThemeData dark() => theme(colorSchemeDark());
  ThemeData light() => theme(colorSchemeLight());

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    textTheme: textTheme(colorScheme),

    primaryColor: colorScheme.primary,
    brightness: colorScheme.brightness,
    scaffoldBackgroundColor: colorScheme.surface,
    canvasColor: colorScheme.surface,
    dividerColor: colorScheme.onSurfaceVariant,
  );
}


extension CustomColorScheme on ColorScheme {
  Color get success => const Color.fromARGB(255, 57, 80, 59);
}
