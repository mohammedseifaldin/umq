import 'package:flutter/material.dart';

import 'EnumNavigationPage.dart';

class ModelNavigation {

  EnumNavigationPage enumNavigationPage;
  String title;
  Widget goToPage;
  IconData iconData;
  int? badgeCounter;

  ModelNavigation({
    required this.enumNavigationPage,
    required String this.title,
    required Widget this.goToPage,
    required IconData this.iconData,
    this.badgeCounter
  });


}