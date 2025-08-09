
enum PersonaName {
  sara,
  kevin,
  john,
  emily,
  michael,
  jessica,
  david,
  emma,
  daniel,
  olivia,
  matthew,
  sophia,
  andrew,
  ava,
  james,
  isabella,
  christopher,
  mia,
  joshua,
  charlotte;

  String toName() {
    final name = nameString();
    return name[0].toUpperCase() + name.substring(1);
  }

  String nameString() => name;

  PersonaName fromName(String value) {
    return PersonaName.values.firstWhere(
      (e) => e.name.toLowerCase() == value.toLowerCase(),
      orElse: () => throw ArgumentError('No Persona with name "$value"'),
    );
  }
}
