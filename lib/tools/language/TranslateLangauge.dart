
import 'dart:convert';

import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';

class TranslateLanguage   {

  static Map<String, dynamic > _jsonAr = Map();
  static Map<String, dynamic > _jsonEn = Map();

  static Future initializeApp(BuildContext context) async {
    String ar =  await DefaultAssetBundle.of( context).loadString('assets/translations/ar-EG.json') ;
    _jsonAr = json.decode( ar  )  ;
    //Log.i("TranslateLanguage - _jsonAr: $_jsonAr");


    String en =  await DefaultAssetBundle.of( context).loadString('assets/translations/en-US.json') ;
    _jsonEn = json.decode( en  )  ;
    //Log.i("TranslateLanguage - _jsonEn: $_jsonEn");

  }


  static String lang(String search){
    //Log.i( "TranslateLanguage - lang() - isCacheArabic: ${LanguageTools.isCacheArabic}");

    //case arabic
    if(LanguageTools.isCacheArabic ) {
      if(_jsonAr.containsKey( search) ) {
        return _jsonAr[search]!;
      }
      return search;
    }
   // Log.i( "TranslateLanguage - lang() - _jsonEn: ${_jsonEn}");
    //Log.i( "TranslateLanguage - lang() - containsKey: ${_jsonEn.containsKey( search)}");

    //defualt english
    if(_jsonEn.containsKey( search) ) {
     // Log.i( "TranslateLanguage - lang() - result: ${_jsonEn[search]}");
      return _jsonEn[search]!;
    }

    return search;
  }
}