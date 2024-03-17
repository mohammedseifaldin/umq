import 'package:flutter/material.dart';
import 'package:umq/toolsUI/app_colors.dart';

snackBar({context, text, duration = 3}) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text.toString(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.normal,
          ),
        ),
        duration: Duration(seconds: duration),
        backgroundColor: blue,
      ),
    );
