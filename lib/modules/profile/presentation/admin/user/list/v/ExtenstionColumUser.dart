
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/profile/presentation/admin/user/list/v/UserListAdminPage.dart';
import 'package:umq/tools/resourceProject/ResourceDimenAdmin.dart';

extension ExtenstionColumUser on UserListAdminState {


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
    list.add( getHeaderCell("photo", AdminDSDimen.header_width_s) );
    list.add( getHeaderCell("name", AdminDSDimen.header_width_l) );
    list.add( getHeaderCell("role", AdminDSDimen.header_width_m) );
    list.add( getHeaderCell("mobile", AdminDSDimen.header_width_m) );
    list.add( getHeaderCell("email", AdminDSDimen.header_width_l) );
    list.add( getHeaderCell("city", AdminDSDimen.header_width_m) );
    list.add( getHeaderCell("edit", AdminDSDimen.header_width_m) );
    list.add( getHeaderCell("block", AdminDSDimen.header_width_m) );
    list.add( getHeaderCell("delete", AdminDSDimen.header_width_m) );
    list.add( getHeaderCell("createdAt", AdminDSDimen.header_width_l) );
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