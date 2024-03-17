
import 'package:flutter/material.dart';

class SnackBarHelper {


  static void ShowErrorMessage(context,message){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message),backgroundColor: Colors.red,));
  }

}