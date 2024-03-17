
import 'package:umq/tools/context/MyApplication.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';

import 'package:umq/tools/values/ToolsValue.dart';


import 'package:flutter/material.dart';
// 

import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';

import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';

class ToolsToast {

  static i(BuildContext context, String  msg , {

    //wait to show message
    int? wait_miliSecond = 300,
    VoidCallback? wait_callBack,
  }){

    //check empty
    if ( ToolsValidation.isEmpty( msg) ) return;
    Log.i( "ToastTools - i() - msg: " + msg );

    //show
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );

    //call back
    if( wait_callBack != null ) {
      ToolsWait.waitToDo( wait_miliSecond!, ()  {
        wait_callBack();
      }
      );
    }


  }







}