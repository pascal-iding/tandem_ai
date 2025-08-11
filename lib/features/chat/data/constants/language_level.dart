enum LanguageLevel {
  a1,
  a2,
  b1,
  b2,
  c1,
  c2;

  String get name {
    switch (this) {
      case LanguageLevel.a1:
        return "A1 - Anfänger";
      case LanguageLevel.a2:
        return "A2 - Anfänger";
      case LanguageLevel.b1:
        return "B1 - Fortgeschritten";
      case LanguageLevel.b2:
        return "B2 - Fortgeschritten";
      case LanguageLevel.c1:
        return "C1 - Sehr fortgeschritten";
      case LanguageLevel.c2:
        return "C2 - Experte";
    }
  }

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

  static List<String> get levelList {
    return LanguageLevel.values.map((level) => level.name).toList();
  }

  static String get defaultLevel {
    return LanguageLevel.b1.name;
  }

  static LanguageLevel fromString(String level) {
    switch (level) {
      case "A1 - Anfänger":
        return LanguageLevel.a1;
      case "A2 - Anfänger":
        return LanguageLevel.a2;
      case "B1 - Fortgeschritten":
        return LanguageLevel.b1;
      case "B2 - Fortgeschritten":
        return LanguageLevel.b2;
      case "C1 - Sehr fortgeschritten":
        return LanguageLevel.c1;
      case "C2 - Experte":
        return LanguageLevel.c2;
      default:
        throw Exception('Unknown level: $level');
    }
  }
}
