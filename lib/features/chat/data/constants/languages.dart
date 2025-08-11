enum Language {
  german,
  english,
  spanish,
  italian;

  String get name {
    switch (this) {
      case Language.german:
        return "Deutsch";
      case Language.english:
        return "Englisch";
      case Language.spanish:
        return "Spanisch";
      case Language.italian:
        return "Italienisch";
    }
  }

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

  static List<String> get languageList {
    return Language.values.map((language) => language.name).toList();
  }

  static String get defaultLanguage {
    return Language.spanish.name;
  }

  static Language fromString(String language) {
    switch (language) {
      case 'Deutsch':
        return Language.german;
      case 'Englisch':
        return Language.english;
      case 'Spanisch':
        return Language.spanish;
      case 'Italienisch':
        return Language.italian;
      default:
        throw Exception('Unknown language: $language');
    }
  }
}
