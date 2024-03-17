import 'package:flutter/cupertino.dart';

class MItemSlide {

  int index;
  Widget pageToOpen;
  IconData iconData;
  String title;

  MItemSlide( {
    required this.index,
    required this.title,
    required this.pageToOpen,
    required this.iconData
});


}