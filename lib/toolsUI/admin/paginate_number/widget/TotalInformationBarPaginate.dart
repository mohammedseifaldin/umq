

import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';


import 'package:umq/toolsUI/toast/ToastTools.dart';



import 'package:fastor_app_ui_widget/resource/template/button/ButtonTemplate.dart';
import 'package:fastor_app_ui_widget/resource/template/row/RowTemplate.dart';
import 'package:fastor_app_ui_widget/resource/template/text/TextTemplate.dart';

import 'package:flutter/material.dart';
import 'package:umq/toolsUI/admin/paginate_number/logic/NumberController.dart';
import 'package:umq/toolsUI/admin/paginate_number/PaginateNumberWidget.dart';

extension TotalInformationBarPaginate on PaginateNumberState {


  Widget totalBarPaginate(){
    var rows =  RowTemplate.wrapChildren( [
      txt_total() ,
      tf_pageGoTo(),
      bt_go() 
    ]);

    //gravity layout
    return Container(
      child: rows,
      // color: Colors.yellow,
      // width: DeviceTools.getWidth(),
      margin: EdgeInsets.symmetric(vertical: DSDimen.space_level_4),
      alignment: Alignment.center,
    );
  }

  Widget txt_total(){
    var txt = "Total "  + widget.pageTotal.toString() + " pages Go To Page";
    return TextTemplate.t( txt , levelDS: LevelDS.l3,
    margin: EdgeInsets.only(left: DSDimen.space_level_2));
  }

  //-------------------------------------------------------------------- GoTo


  Widget tf_pageGoTo() {
    return TextFieldFastor(

      decoration: BoarderHelper.box(
        // radiusSize: 0,
        // colorBackground: Colors.transparent,
        colorLine: Colors.black
      ),
      hint_color: Colors.transparent,
      keyboardType: TextInputType.number,
      margin: EdgeInsets.only(left: DSDimen.space_level_3 ),
      padding: EdgeInsets.all( 7 ),
      controller:  tf_goto_controller,
      //savge change
      onChanged: (s){

        updateGoToPage(s );

      },
        width: 60
    );

  }

  void updateGoToPage(String newPage ) {
    try {
      pageGoTo = int.parse( newPage );
    }catch (e ){
      /**
       * some time open by keyboard
       */
      Log.e( "paginate - updateGoToPage() exc: " + e.toString()  );
    }

  }
  
  Widget bt_go(){
    return ButtonTemplate.t( "Go" , () {

      goToClickFunction();

    } ,
        margin: EdgeInsets.only(left: DSDimen.space_level_3 ),
        levelDS: LevelDS.l2
    );
  }

  void goToClickFunction(){
    //check zero
    if( pageGoTo <= 0 ) {
      ToolsToast.i( context,  "Missed Field Go To Page" );
      return;
    }

    //more than maxPage
    Log.i( "goToClickFunction() - maxPage: " + widget.maxPage.toString()  );
    if( pageGoTo >= widget.maxPage!  ) {
      ToolsToast.i( context,  "Page more than Maximum Page is: " + widget.maxPage.toString()  );
      return;
    }

    //more than totalPages
    if( pageGoTo >  widget.pageTotal  ) {
      ToolsToast.i( context,  "Page more than totalBar Page is: " + widget.pageTotal.toString()  );
      return;
    }

    //update
   // setPaginateByRecordTotal( recordTotal, widget.limitPerPage, pageGoTo);

    //call back
    widget.paginateNumberChange( pageGoTo);
  }
  
  
}