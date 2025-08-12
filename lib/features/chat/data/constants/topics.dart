import 'package:flutter/material.dart';
import 'package:tandem_ai/l10n/app_localizations.dart';

enum Topic {
  leisure,
  business,
  travel,
  food;

  String getName(BuildContext context) {
    switch (this) {
      case Topic.leisure:
        return AppLocalizations.of(context)!.leisure;
      case Topic.business:
        return AppLocalizations.of(context)!.business;
      case Topic.travel:
        return AppLocalizations.of(context)!.travel;
      case Topic.food:
        return AppLocalizations.of(context)!.food;
    }
  }

  /// Used for chatgpt instructions
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

  static List<String> getTopicList(BuildContext context) {
    return Topic.values.map((topic) => topic.getName(context)).toList();
  }

  static String getdefaultTopic(BuildContext context) {
    return Topic.leisure.getName(context);
  }

  static Topic fromString(String topic, BuildContext context) {
    if (topic == AppLocalizations.of(context)!.leisure) {
      return Topic.leisure;
    } else if (topic == AppLocalizations.of(context)!.business) {
      return Topic.business;
    } else if (topic == AppLocalizations.of(context)!.travel) {
      return Topic.travel;
    } else if (topic == AppLocalizations.of(context)!.food) {
      return Topic.food;
    } else {
      throw Exception('Unknown topic: $topic');
    }
  }
}
