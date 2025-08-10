
enum Topic {
  leisure,
  business,
  travel,
  food
}

String getTopicName(Topic topic) {
  switch (topic) {
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

List<String> getTopicList() {
  return Topic.values.map((topic) => getTopicName(topic)).toList();
}

String getDefaultTopic() {
  return getTopicName(Topic.leisure);
}

Topic getTopic(String topic) {
  switch (topic) {
    case 'Freizeit': 
      return Topic.leisure;
    case 'Geschäftlich':
      return Topic.business;
    case 'Reisen':
      return Topic.travel;
    case 'Essen':
      return Topic.food;
  }
  throw Exception('Unknown topic: $topic');
}
