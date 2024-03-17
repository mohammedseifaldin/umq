import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:need_resume/need_resume.dart';

import 'MyApplication.dart';


class ManageWidget {


  static List<Widget> _listWidget_StatelessWidget =   [];
  static List<ResumableState> _listWidget_ResumableState =   [];

  /**
      - at class call
      Widget build(BuildContext context) {
      MyApplication.setWidget( this);
   */
  static setWidget_StatelessWidget(  Widget w ) {
    _listWidget_StatelessWidget.add( w);
  }

  static setWidget_ResumableState(  ResumableState resume ) {
    _listWidget_ResumableState.add( resume);
  }

  //---------------------------------------------------------------------- log all

  static logAllWidget(){
    // Log.i( "logAllPages() - start list: $_listContext" ) ;

    _listWidget_StatelessWidget.forEach((e){
      Log.i( "logAllPages() - _listWidget_StatelessWidget - loop $e" ) ;

    });

    _listWidget_ResumableState.forEach((e){
      Log.i( "logAllPages() - _listWidget_ResumableState - loop $e" ) ;

    });

  }


}