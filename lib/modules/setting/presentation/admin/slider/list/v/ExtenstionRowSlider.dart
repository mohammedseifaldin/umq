
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/setting/presentation/admin/slider/list/c/ExtensionRowButtonController.dart';
import 'package:umq/modules/setting/presentation/admin/slider/list/v/SliderListAdminPage.dart';

import 'package:umq/toolsUI/admin/itemRowTable/cell_button.dart';
import 'package:umq/toolsUI/admin/itemRowTable/cell_id_primary.dart';
import 'package:umq/toolsUI/admin/itemRowTable/cell_image_single.dart';
import 'package:umq/toolsUI/admin/itemRowTable/cell_txt.dart';
import 'package:umq/modules/home/data/model/MSlider.dart';
import 'package:umq/modules/profile/data/model/m_user.dart';
import 'package:umq/tools/resourceProject/ResourceDimenAdmin.dart';
import 'package:umq/modules/place/data/model/MCityTools.dart';
import 'package:umq/tools/network/ToolsAPI.dart';
import 'package:umq/tools/time/TimeTools.dart';
import 'package:universal_io/io.dart';

extension ExtenstionRowSlider on SliderListAdminState {


  //--------------------------------------------------------------------  single row

  /**
   * single row to print "Record"
   */
  Future<Widget> rowItemResult(MSlider m  )  async {
    var row =  Row( children: await listCellForSingleRecord(m  ) );
    return Container( child:  row ,
        margin: EdgeInsets.symmetric(horizontal: DSDimen.space_level_1 )
    );
  }


  /**
   * the list horizontal to show data of record
   */
  Future<List<Widget>> listCellForSingleRecord(MSlider m  ) async {

    List<Widget> list = [];

    list.add( cell_image_single( m.image , 200, height: AdminDSDimen.row_height_xxx) );

    //id show
    list.add( cell_id_primary( m.id, AdminDSDimen.header_width_m, height: AdminDSDimen.row_height_xxx,  () async {
      await  click_show_detail(m);
    }) );


    //delete
    list.add( cell_button("Trash", AdminDSDimen.header_width_m, height: AdminDSDimen.row_height_xxx, () async {  await hidden_click(m);  }) );
    var time = TimeTools.convertTimestamp_yyymmddhhmmPM( m.createdAt!  );
    list.add( cell_text( time, AdminDSDimen.header_width_l, height: AdminDSDimen.row_height_xxx) );

    //fix table wrong sorting
 //   sleep(Duration(milliseconds: 50 ));

    //log
    // Log.i( "listCellForSingleRecord() - id: " + m.id.toString() );
    // Log.i( "listCellForSingleRecord() - *************** "   );

    return list;
  }





}