import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:umq/tools/resourceProject/ColorProject.dart';

class ToolbarTransparent extends StatelessWidget {

  //------------------------------------------------------------  variable and constructor

  String title;
  Color colorPrimary;
  BuildContext pageContext;

  ToolbarTransparent(this.pageContext, this.title, this.colorPrimary);

  //----------------------------------------------------------------------- build

  var isArabic = false;

  @override
  Widget build(BuildContext context) {
    isArabic = LanguageTools.isArabic( context);

    if ( isArabic ) {
      return toolbar_arabic();
    } else {
      return toolbar_english();
    }

  }

  //--------------------------------------------------------------------- arabic/english

  Widget toolbar_english() {
    return Stack( children: [

      EmptyView.empty( DeviceTools.getWidth(pageContext), 50),

      Positioned(child:  bt_back() , left:  0 ),

      Positioned(child:  tv_title(), left:  45 , top: 10,)

    ]);
  }


  Widget toolbar_arabic() {
    return Stack( children: [

      EmptyView.empty( DeviceTools.getWidth(pageContext), 50),

      Positioned(child:  bt_back() , right:  0 ),

      Positioned(child:  tv_title(), right:  45 , top: 10,)

    ]);
  }

  //--------------------------------------------------------------------- content

  Widget bt_back() {
    var bt =  BackButton(
      color: colorPrimary,// HexColor( ColorProject.black_4),
    );

    //rotate arabic
    /**
     this default app come from flutter sdk not need to rotate
     */

    return bt;
  }


  Widget tv_title(){
    return TextTemplate.t( title, color: colorPrimary );
  }



}