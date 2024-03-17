
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/product/data/model/MProduct.dart';

class MProductTools {


  static String getNameByLang(BuildContext context, MProduct? m ) {
    if( m == null )return"";
    if( LanguageTools.isArabic(context) ) {
      return m.nameAr??"" ;
    } else {
      return m.nameEn??"";
    }
  }


  static String getDescriptionByLang(BuildContext context, MProduct m) {
    if( m == null )return"";
    if( LanguageTools.isArabic(context) ) {
      return m.description_ar??"" ;
    } else {
      return m.description_en??"";
    }
  }


  static String generateNameAndRentText(BuildContext context, MProduct m ) {
    String name = MProductTools.getNameByLang(context, m );
    String type = m.rent!;
    return name + " ( " + type + " )";
  }


}