

import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/toolsUI/admin/paginate/v/PaginateAdminWidget.dart';

import 'package:umq/toolsUI/toast/ToastTools.dart';



import 'package:fastor_app_ui_widget/resource/template/button/ButtonTemplate.dart';
import 'package:fastor_app_ui_widget/resource/template/row/RowTemplate.dart';
import 'package:fastor_app_ui_widget/resource/template/text/TextTemplate.dart';
// import 'package:fastor_app_ui_widget/resource/template/textfield/TextFieldTemplate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension TotalInformationBarPaginate on PaginateAdminState {


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
    var txt = "Total "  + pageTotal.toString() + " pages Go To Page";
    return TextTemplate.t( txt , levelDS: LevelDS.l3,
    margin: EdgeInsets.only(left: DSDimen.space_level_2));
  }

  //-------------------------------------------------------------------- GoTo


  Widget tf_pageGoTo() {
    tf_goTo =  TextFieldFastor(

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

    return tf_goTo;
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
        //padding: EdgeInsets.symmetric( horizontal: DSDimen.space_level_3, vertical: DSDimen.space_level_4 ),
        // textColor: F.black,
        levelDS: LevelDS.l2,
       // background: Colors.transparent,
        // borderRadius: DSDimen.ds_button_large_corner ,
        // borderLine: Colors.black
    );

  }

  void goToClickFunction(){
    //check zero
    if( pageGoTo <= 0 ) {
      ToolsToast.i( context,  "Missed Field Go To Page" );
      return;
    }

    //more than maxPage
    Log.i( "goToClickFunction() - maxPage: " + maxPage.toString()  );
    if( pageGoTo >= maxPage  ) {
      ToolsToast.i( context,  "Page more than Maximum Page is: " + maxPage.toString()  );
      return;
    }

    //more than totalPages
    if( pageGoTo >  pageTotal  ) {
      ToolsToast.i( context,  "Page more than totalBar Page is: " + pageTotal.toString()  );
      return;
    }

    //update
    setPaginateByRecordTotal( recordTotal, limitPerPage, pageGoTo);

    //call back
    callBack( pageGoTo);
  }
  
  
}