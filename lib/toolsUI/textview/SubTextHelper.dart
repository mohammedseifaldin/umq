import 'package:flutter/material.dart';
import 'package:umq/toolsUI/ThemeColor.dart';

class SubTextHelper {



  static Text SubText(String txt,{textAlign,double fontSize=14,color,maxLine}){
    return Text(txt,
      textAlign: textAlign,
      maxLines: maxLine,
      style: TextStyle(
          fontSize: fontSize,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.normal,
          fontFamily:'Schyler',
          decoration: TextDecoration.none,
          color: color==null?ThemeColor.colorText:color),
    );
  }

}