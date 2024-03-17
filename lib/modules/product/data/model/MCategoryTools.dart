import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:umq/modules/product/data/model/MCategory.dart';

class MCategoryTools {

  static String getNameByLang(BuildContext context, MCategory? m ) {
    if( m == null )return"";
    if( LanguageTools.isArabic(context) ) {
      return m.nameAr??"";
    } else {
      return m.nameEn??"";
    }
  }


}