enum Topic {
  leisure,
  business,
  travel,
  food;

  String get name {
    switch (this) {
      case Topic.leisure:
        return "Freizeit";
      case Topic.business:
        return "Geschäftlich";
      case Topic.travel:
        return "Reisen";
      case Topic.food:
        return "Essen";
    }
  }

  String get nameEn {
    switch (this) {
      case Topic.leisure:
        return "Leisure";
      case Topic.business:
        return "Business";
      case Topic.travel:
        return "Travel";
      case Topic.food:
        return "Food";
    }
  }

  static List<String> get topicList {
    return Topic.values.map((topic) => topic.name).toList();
  }

  static String get defaultTopic {
    return Topic.leisure.name;
  }

  static Topic fromString(String topic) {
    switch (topic) {
      case 'Freizeit':
        return Topic.leisure;
      case 'Geschäftlich':
        return Topic.business;
      case 'Reisen':
        return Topic.travel;
      case 'Essen':
        return Topic.food;
      default:
        throw Exception('Unknown topic: $topic');
    }
  }
}
