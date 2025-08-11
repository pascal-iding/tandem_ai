
enum Language {
  german,
  english,
  spanish,
  italian
}

String getLanguageName(Language language) {
  switch (language) {
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

String getLanguageNameEn(Language language) {
  switch (language) {
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

List<String> getLanguageList() {
  return Language.values.map((language) => getLanguageName(language)).toList();
}

String getDefaultLanguage() {
  return getLanguageName(Language.spanish);
}

Language getLanguage(String language) {
  switch (language) {
    case 'Deutsch': 
      return Language.german;
    case 'Englisch':
      return Language.english;
    case 'Spanisch':
      return Language.spanish;
    case 'Italienisch':
      return Language.italian;
  }
  throw Exception('Unknown language: $language');
}
