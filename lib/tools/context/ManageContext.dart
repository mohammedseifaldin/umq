import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:need_resume/need_resume.dart';


import 'ManageWidget.dart';
import 'MyApplication.dart';


abstract class ManageContext   { //implements IManageContext

  //------------------------------------------------------------------- variable

  static BuildContext? _context = null ;
  static List<BuildContext> _listContext =   [];

  //------------------------------------------------------------------- public method

  static BuildContext getContext() { return _context!; }


  static setContext(BuildContext ctx ) {

    //set current
    _context  = ctx;

    //appened
    _listContext.add( ctx );
  }


  //---------------------------------------------------------------------- finish

  /**
      for loop all previous "GoTo" pages and make finish it by Navigaor.pop()"
   */
  static finishLastPage(){
    /**
     * log backend
     */
    _listContext.forEach((e){
      Log.i( "logAllPages() - _listContext - loop $e" ) ;
    });


    //kill last
    if ( _listContext.length > 0 ) {
      BuildContext last = _listContext.last;
      Log.i( "logAllPages() - last $last" ) ;
      Navigator.of( last).pop();
    }
  }



}