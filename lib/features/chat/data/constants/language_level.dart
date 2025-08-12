import 'package:flutter/widgets.dart';
import 'package:tandem_ai/l10n/app_localizations.dart';

enum LanguageLevel {
  a1,
  a2,
  b1,
  b2,
  c1,
  c2;

  String getName(BuildContext context) {
    switch (this) {
      case LanguageLevel.a1:
        return AppLocalizations.of(context)!.a1;
      case LanguageLevel.a2:
        return AppLocalizations.of(context)!.a2;
      case LanguageLevel.b1:
        return AppLocalizations.of(context)!.b1;
      case LanguageLevel.b2:
        return AppLocalizations.of(context)!.b2;
      case LanguageLevel.c1:
        return AppLocalizations.of(context)!.c1;
      case LanguageLevel.c2:
        return AppLocalizations.of(context)!.c2;
    }
  }

  /// Used for chatgpt instructions
  String get nameEn {
    switch (this) {
      case LanguageLevel.a1:
        return "A1 - Beginner";
      case LanguageLevel.a2:
        return "A2 - Beginner";
      case LanguageLevel.b1:
        return "B1 - Advanced";
      case LanguageLevel.b2:
        return "B2 - Advanced";
      case LanguageLevel.c1:
        return "C1 - Very advanced";
      case LanguageLevel.c2:
        return "C2 - Expert";
    }
  }

  static List<String> getLevelList(BuildContext context) {
    return LanguageLevel.values.map((level) => level.getName(context)).toList();
  }

  static String getDefaultLevel(BuildContext context) {
    return LanguageLevel.b1.getName(context);
  }

  static LanguageLevel fromString(String level, BuildContext context) {
    if (level == AppLocalizations.of(context)!.a1) {
      return LanguageLevel.a1;
    } else if (level == AppLocalizations.of(context)!.a2) {
      return LanguageLevel.a2;
    } else if (level == AppLocalizations.of(context)!.b1) {
      return LanguageLevel.b1;
    } else if (level == AppLocalizations.of(context)!.b2) {
      return LanguageLevel.b2;
    } else if (level == AppLocalizations.of(context)!.c1) {
      return LanguageLevel.c1;
    } else if (level == AppLocalizations.of(context)!.c2) {
      return LanguageLevel.c2;
    } else {
      throw Exception('Unknown level: $level');
    }
  }
}
