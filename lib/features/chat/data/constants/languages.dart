import 'package:flutter/widgets.dart';
import 'package:tandem_ai/l10n/app_localizations.dart';

enum Language {
  german,
  english,
  spanish,
  italian;

  String getName(BuildContext context) {
    switch (this) {
      case Language.german:
        return AppLocalizations.of(context)!.german;
      case Language.english:
        return AppLocalizations.of(context)!.english;
      case Language.spanish:
        return AppLocalizations.of(context)!.spanish;
      case Language.italian:
        return AppLocalizations.of(context)!.italian;
    }
  }

  /// Used for chatgpt instructions
  String get nameEn {
    switch (this) {
      case Language.german:
        return "German";
      case Language.english:
        return "English";
      case Language.spanish:
        return "Spanish";
      case Language.italian:
        return "Italian";
    }
  }

  static List<String> getLanguageList(BuildContext context) {
    return Language.values
        .map((language) => language.getName(context))
        .toList();
  }

  static String getDefaultLanguage(BuildContext context) {
    return Language.spanish.getName(context);
  }

  static Language fromString(String language, BuildContext context) {
    if (language == AppLocalizations.of(context)!.german) {
      return Language.german;
    } else if (language == AppLocalizations.of(context)!.english) {
      return Language.english;
    } else if (language == AppLocalizations.of(context)!.spanish) {
      return Language.spanish;
    } else if (language == AppLocalizations.of(context)!.italian) {
      return Language.italian;
    } else {
      throw Exception('Unknown language: $language');
    }
  }
}
