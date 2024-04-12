import 'package:flutter/material.dart';

class ThemeColor {
  static Color colorPrimary = hexToColor('#144777');
  static Color colorProgressBG = Colors.transparent;
  static Color colorSecoundry = hexToColor('#6588A8');
  static Color colorBtnPrimary = hexToColor('#01ACF1');
  static Color colorBtnText = Colors.white;
  static Color colorText = Colors.black;
  static Color colorTextGray = Colors.grey.shade600;
  static Color colorInputText = Colors.white;
  static Color colorDivider = Colors.grey;
  static Color colorTranperent = Colors.transparent;

  static Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }
}
