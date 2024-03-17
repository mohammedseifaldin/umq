
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/profile/presentation/admin/user/list/c/ExtensionRowButtonController.dart';
import 'package:umq/modules/profile/presentation/admin/user/list/v/UserListAdminPage.dart';
import 'package:umq/toolsUI/admin/itemRowTable/cell_button.dart';
import 'package:umq/toolsUI/admin/itemRowTable/cell_id_primary.dart';
import 'package:umq/toolsUI/admin/itemRowTable/cell_image_single.dart';
import 'package:umq/toolsUI/admin/itemRowTable/cell_txt.dart';
import 'package:umq/modules/profile/data/model/m_user.dart';
import 'package:umq/tools/resourceProject/ResourceDimenAdmin.dart';
import 'package:umq/modules/place/data/model/MCityTools.dart';
import 'package:umq/tools/network/ToolsAPI.dart';
import 'package:umq/tools/time/TimeTools.dart';
import 'package:universal_io/io.dart';

extension ExtenstionRowUser on UserListAdminState {


  //--------------------------------------------------------------------  single row

  /**
   * single row to print "Record"
   */
  Future<Widget> rowItemResult(MUser m  )  async {
    var row =  Row( children: await listCellForSingleRecord(m  ) );
    return Container( child:  row ,
        margin: EdgeInsets.symmetric(horizontal: DSDimen.space_level_1 )
    );
  }


  /**
   * the list horizontal to show data of record
   */
  Future<List<Widget>> listCellForSingleRecord(MUser m  ) async {

    List<Widget> list = [];

    list.add( cell_image_single( m.photo , AdminDSDimen.header_width_s) );
    list.add( cell_text( m.name, AdminDSDimen.header_width_l) );
    list.add( cell_text( m.role, AdminDSDimen.header_width_m) );
    list.add( cell_text( m.mobile, AdminDSDimen.header_width_m) );
    list.add( cell_text( m.email, AdminDSDimen.header_width_l) );

    //city
    String cityName = MCityTools.getNameByLang(context, m.city);
    list.add( cell_text(cityName, AdminDSDimen.header_width_m) );

    //id show
    list.add( cell_id_primary( m.id, AdminDSDimen.header_width_m, () async {
      await  click_show_detail(m);
    }) );

    //block
    String titleBlockStatus = ToolsAPI.parseBoolean_int( m.block ) ? "remove block" : "block";
    list.add( cell_button(titleBlockStatus, AdminDSDimen.header_width_m, () async  {  await  block_click(m);  }) );

    //delete
    list.add( cell_button("Trash", AdminDSDimen.header_width_m, () async {  await hidden_click(m);  }) );

    //date
    var time = TimeTools.convertTimestamp_yyymmddhhmmPM( m.createdAt!  );
    list.add( cell_text( time, AdminDSDimen.header_width_l) );

    //fix table wrong sorting
  //  sleep(Duration(milliseconds: 50 ));

    //log
    // Log.i( "listCellForSingleRecord() - id: " + m.id.toString() );
    // Log.i( "listCellForSingleRecord() - *************** "   );

    return list;
  }





}