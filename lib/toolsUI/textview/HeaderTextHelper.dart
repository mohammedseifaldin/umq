import 'package:flutter/material.dart';
import 'package:umq/toolsUI/ThemeColor.dart';

class HeaderTextHelper {
  static Text HeaderText(String txt, {textAlign, maxLines, color}) {
    return Text(
      txt,
      textAlign: textAlign,
      maxLines: maxLines,
      style: TextStyle(
        fontSize: 20,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.none,
        color: color ?? ThemeColor.colorText,
        fontFamily: 'Schyler',
      ),
    );
  }
}
