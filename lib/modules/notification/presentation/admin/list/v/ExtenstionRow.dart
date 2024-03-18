
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/notification/data/model/MNotificationAdmin.dart';
import 'package:umq/tools/resourceProject/ResourceDimenAdmin.dart';
import 'package:umq/tools/time/TimeTools.dart';
import 'package:umq/toolsUI/admin/itemRowTable/cell_txt.dart';

import 'NotificationListAdminPage.dart';


extension ExtenstionRow on NotificationListAdminState {


  //--------------------------------------------------------------------  single row

  /**
   * single row to print "Record"
   */
  Future<Widget> rowItemResult(MNotificationAdmin m  )  async {
    var row =  Row( children: await listCellForSingleRecord(m  ) );
    return Container( child:  row ,
        margin: EdgeInsets.symmetric(horizontal: DSDimen.space_level_1 )
    );
  }


  /**
   * the list horizontal to show data of record
   */
  Future<List<Widget>> listCellForSingleRecord(MNotificationAdmin m  ) async {

    List<Widget> list = [];

    //date
    String date = TimeTools.convertTimestamp_yyymmddhhmmPM( m.created!);
    list.add( cell_text( date, AdminDSDimen.header_width_l, height : AdminDSDimen.row_height_l ) );

    //message
    list.add( cell_text( m.title, AdminDSDimen.header_width_l, height : AdminDSDimen.row_height_l ) );
    list.add( cell_text( m.message, AdminDSDimen.header_width_xl, height : AdminDSDimen.row_height_l ) );

    //topic
    String valueTopic = "";
    bool isAll = m.topic!.contains( "all");
    bool isHaveUserTarget = m.userTarget != null;
    if( isAll ) {
      valueTopic = "All Users";
    } else if(isHaveUserTarget  ) {
      valueTopic = m.userTarget!.name!;
    }
    list.add( cell_text(valueTopic,  AdminDSDimen.header_width_l, height : AdminDSDimen.row_height_l  ) );

    //fix table wrong sorting
   // sleep(Duration(milliseconds: 50 ));

    return list;
  }





}