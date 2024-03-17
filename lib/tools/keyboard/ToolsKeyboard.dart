import 'package:flutter/material.dart';

class ToolsKeyboard {

  static Future<bool> dismiss(BuildContext context ) async  {
    FocusScope.of( context).unfocus();
    return true;
  }
}