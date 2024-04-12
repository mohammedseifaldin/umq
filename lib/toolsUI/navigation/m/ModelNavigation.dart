import 'package:flutter/material.dart';

import 'EnumNavigationPage.dart';

class ModelNavigation {
  EnumNavigationPage enumNavigationPage;
  String title;
  Widget goToPage;
  IconData iconData;
  int? badgeCounter;

  ModelNavigation(
      {required this.enumNavigationPage,
      required this.title,
      required this.goToPage,
      required this.iconData,
      this.badgeCounter});
}
