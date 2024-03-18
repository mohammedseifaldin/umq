
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/subscribe/data/model/MSubscribeUser.dart';
import 'package:umq/modules/subscribe/presentation/admin/user_list/SubscribeUsersListAdminPage.dart';
import 'package:umq/tools/network/ToolsAPI.dart';
import 'package:umq/tools/resourceProject/ResourceDimenAdmin.dart';
import 'package:umq/tools/time/TimeTools.dart';
import 'package:umq/toolsUI/admin/itemRowTable/cell_bool.dart';
import 'package:umq/toolsUI/admin/itemRowTable/cell_image_single.dart';
import 'package:umq/toolsUI/admin/itemRowTable/cell_price.dart';
import 'package:umq/toolsUI/admin/itemRowTable/cell_txt.dart';


extension ExtenstionRow on SubscribeUsersListAdminPageState {


  //--------------------------------------------------------------------  single row

  /**
   * single row to print "Record"
   */
   Widget  rowItemResult(MSubscribeUser m  )    {
    var row =  Row( children:   listCellForSingleRecord(m  ) );
    return Container( child:  row ,
        margin: EdgeInsets.symmetric(horizontal: DSDimen.space_level_1 )
    );
  }


  /**
   * the list horizontal to show data of record
   */
   List<Widget>  listCellForSingleRecord(MSubscribeUser m  )   {

    List<Widget> list = [];

    //date
    String date = TimeTools.convertTimestamp_yyymmddhhmmPM( int.parse( m.created.toString() )  );
    list.add( cell_text(date, AdminDSDimen.header_width_l) );

    //user info
    list.add( cell_text( m.userName.toString(), AdminDSDimen.header_width_l) );
    list.add( cell_image_single( m.userImage, AdminDSDimen.header_width_s) );

    //package info
    list.add( cell_text( m.packageName.toString(), AdminDSDimen.header_width_l) );
    list.add( cell_text( m.packagePeriod.toString(), AdminDSDimen.header_width_m) );
    list.add( cell_text( m.packageAllowedProductNumers.toString(), AdminDSDimen.header_width_m) );
    list.add( cell_bool( ToolsAPI.isSuccess(int.parse(m.packageAllowedChat.toString())) , AdminDSDimen.header_width_s) );

    //price
    double parsePrice =  double.parse(m.price.toString() +  ".00");
    list.add( cell_price( parsePrice, AdminDSDimen.header_width_m) );

    //payment info
    list.add( cell_text( m.paymentMethod??"-", AdminDSDimen.header_width_m) );
    list.add( cell_text( m.paymentTransactionId??"-", AdminDSDimen.header_width_m) );
    list.add( cell_bool( ToolsAPI.isSuccess(int.parse(m.byAdmin.toString())), AdminDSDimen.header_width_s) );
    return list;
  }





}