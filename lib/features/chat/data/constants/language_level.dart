
enum LanguageLevel {
  a1,
  a2,
  b1,
  b2,
  c1,
  c2
}

String getLevelName(LanguageLevel level) {
  switch (level) {
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

List<String> getLevelList() {
  return LanguageLevel.values.map((level) => getLevelName(level)).toList();
}

String getDefaultLevel() {
  return getLevelName(LanguageLevel.b1);
}

LanguageLevel getLevel(String level) {
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
  }
  throw Exception('Unknown level: $level');
}
