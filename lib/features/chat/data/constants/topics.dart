import 'package:flutter/material.dart';
import 'package:tandem_ai/l10n/app_localizations.dart';
import 'package:tandem_ai/shared/widgets/form_elements/dropdowns/searchable_dropdown/searchable_dropdown.dart';


enum Topic {
  movies,
  sports,
  gaming,
  photography,
  businessOpportunities,
  career,
  dreamTravelDestination,
  culture;

  String getName(BuildContext context) {
    switch (this) {
      case Topic.movies:
        return AppLocalizations.of(context)!.movies;
      case Topic.sports:
        return AppLocalizations.of(context)!.sports;
      case Topic.gaming:
        return AppLocalizations.of(context)!.gaming;
      case Topic.photography:
        return AppLocalizations.of(context)!.photography;
      case Topic.businessOpportunities:
        return AppLocalizations.of(context)!.businessOpportunities;
      case Topic.career:
        return AppLocalizations.of(context)!.career;
      case Topic.dreamTravelDestination:
        return AppLocalizations.of(context)!.dreamTravelDestination;
      case Topic.culture:
        return AppLocalizations.of(context)!.culture;
    }
  }

  /// Used for chatgpt instructions
  String get nameEn {
    switch (this) {
      case Topic.movies:
        return "Movies";
      case Topic.sports:
        return "Sports";
      case Topic.gaming:
        return "Gaming";
      case Topic.photography:
        return "Photography";
      case Topic.businessOpportunities:
        return "Business opportunities";
      case Topic.career:
        return "Career";
      case Topic.dreamTravelDestination:
        return "Dream travel destination";
      case Topic.culture:
        return "Culture";
    }
  }

  static List<String> getTopicList(BuildContext context) {
    return Topic.values.map((topic) => topic.getName(context)).toList();
  }

  static String getdefaultTopic(BuildContext context) {
    return Topic.movies.getName(context);
  }

  static Topic fromString(String topic, BuildContext context) {
    if (topic == AppLocalizations.of(context)!.movies) {
      return Topic.movies;
    } else if (topic == AppLocalizations.of(context)!.sports) {
      return Topic.sports;
    } else if (topic == AppLocalizations.of(context)!.gaming) {
      return Topic.gaming;
    } else if (topic == AppLocalizations.of(context)!.photography) {
      return Topic.photography;
    } else if (topic == AppLocalizations.of(context)!.businessOpportunities) {
      return Topic.businessOpportunities;
    } else if (topic == AppLocalizations.of(context)!.career) {
      return Topic.career;
    }else if (topic == AppLocalizations.of(context)!.dreamTravelDestination) {
      return Topic.dreamTravelDestination;
    } else if (topic == AppLocalizations.of(context)!.culture) {
      return Topic.culture;
    } else {
      throw Exception('Unknown topic: $topic');
    }
  }

  static List<DropdownCategory> getLanguageCategories(BuildContext context) {
    return [
      DropdownCategory(
        name: 'Leisure',
        items: [
          Topic.movies.getName(context),
          Topic.sports.getName(context),
          Topic.gaming.getName(context),
          Topic.photography.getName(context)
        ],
      ),
      DropdownCategory(
        name: 'Business',
        items: [
          Topic.career.getName(context),
          Topic.businessOpportunities.getName(context),
        ],
      ),
      DropdownCategory(
        name: 'Travel',
        items: [
          Topic.dreamTravelDestination.getName(context),
          Topic.culture.getName(context)
        ],
      ),
    ];
  }
}
