
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:umq/tools/resourceProject/ResourceDimenAdmin.dart';

import 'NotificationListAdminPage.dart';

extension ExtenstionColum  on NotificationListAdminState {


  Widget columnHeader() {
   var row =  Row(children: cellHeaderList() );
  //   return EmptyView.colored( 500 , 50, Colors.orange );

    return Container( child:  row ,
        margin: EdgeInsets.symmetric(horizontal: DSDimen.space_level_1 )
    );
  }

  //-------------------------------------------------------------------- map to widget

  List<Widget> cellHeaderList() {
    List<Widget> list = [];
/*


    list.add( cell_text( date, AdminDSDimen.header_width_l) );

    list.add( cell_text( m.title, AdminDSDimen.header_width_l) );
    list.add( cell_text( m.message, AdminDSDimen.header_width_xxx) );

    list.add( cell_text(valueTopic,  AdminDSDimen.header_width_l ) );

* */
    list.add( getHeaderCell("Date", AdminDSDimen.header_width_l) );
    list.add( getHeaderCell("Title", AdminDSDimen.header_width_l) );
    list.add( getHeaderCell("Message", AdminDSDimen.header_width_xl) );
    list.add( getHeaderCell("To", AdminDSDimen.header_width_l) );
    return list;
  }

  //-------------------------------------------------------------------- header cell

  Widget getHeaderCell(String s, double width ) {
    //stack
    return Stack( children: [
      box(width),
      txt(s, width)
    ] );
  }


  Widget txt(String s, double width ) {
    return   TextTemplate.t( s,
        levelDS: LevelDS.l2,
       // color: ResourceColorAdmin.table_header_title,
        color: DSColor.table_header_title,

        padding: EdgeInsets.only(left: 5),
        width: width,
        height: AdminDSDimen.header_height_m,
        gravityLayoutAlign: Alignment.center
    );
  }


  Widget box(double width ) {
    return   Container(
      width : width,
      height: AdminDSDimen.header_height_m,
      decoration: BoarderHelper.rounded(
          radiusSize: 0,
        colorBackground: DSColor.table_header_background,
          // colorBackground: ResourceColorAdmin.table_header_background,
          colorLine: DSColor.table_header_boader
          // colorLine: ResourceColorAdmin.table_header_line
      ),
    );
  }




}