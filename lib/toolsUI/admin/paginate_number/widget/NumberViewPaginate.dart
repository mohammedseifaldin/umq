

import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';




import 'package:umq/toolsUI/admin/paginate_number/logic/NumberController.dart';
import 'package:umq/toolsUI/admin/paginate_number/PaginateNumberWidget.dart';

import 'package:fastor_app_ui_widget/resource/template/click/GestureDetectorTemplate.dart';
import 'package:fastor_app_ui_widget/resource/template/text/TextTemplate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../PaginateNumberWidget.dart';


extension NumberViewPaginate on PaginateNumberState {

  //----------------------------------------------------------------------- build

  Widget boxNumber({
    required int page ,
    required bool isSelected}){

    var textWidget =  TextTemplate.t( "" + page.toString()  ,

        levelDS: LevelDS.l3,
    color: Colors.white,
    padding: EdgeInsets.symmetric( horizontal: DSDimen.space_level_4 , vertical: 6),
    margin: EdgeInsets.only( right: DSDimen.space_level_4 ),
    height: 25,
    decoration: isSelected? decoration_selected() : decoration_unselected()
    );

   return setupClickOnThisNumber( page, isSelected, textWidget);
    // return textWidget;
  }


  BoxDecoration decoration_selected() {
    return BoarderHelper.rounded(
      radiusSize: DSDimen.ds_size_corner_level_4 ,
      colorBackground: DSColor.tap_active
    );
  }


  BoxDecoration decoration_unselected() {
    return BoarderHelper.rounded( radiusSize: DSDimen.ds_size_corner_level_4 ,
    colorBackground: DSColor.tap_inactive );
  }

  //------------------------------------------------------------------------- click on number

  Widget setupClickOnThisNumber(int page, bool isSelected, Widget textWidget) {

    return GestureDetectorTemplate.t(child : textWidget, onPressed:  (){
      Log.i( "boxNumber() - Click " + page.toString()  );

      // //update selected
      // widget.currentPage = page;
      // drawListNumberWidget();

      //interface
      widget.paginateNumberChange(page);
    }
    , paddingClick: EdgeInsets.all(5 ) );
  }


 }
