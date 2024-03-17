
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/place/presentation/admin/city/list/c/ExtensionRowButtonController.dart';

import 'package:umq/toolsUI/admin/itemRowTable/cell_button.dart';
import 'package:umq/toolsUI/admin/itemRowTable/cell_id_primary.dart';

import 'package:umq/toolsUI/admin/itemRowTable/cell_txt.dart';
import 'package:umq/modules/place/data/model/MCity.dart';

import 'package:umq/tools/resourceProject/ResourceDimenAdmin.dart';

import 'package:universal_io/io.dart';

import 'CityListAdminPage.dart';

@Deprecated( "not used until today")
extension ExtenstionRow on CityListAdminState {


  //--------------------------------------------------------------------  single row

  /**
   * single row to print "Record"
   */
  Future<Widget> rowItemResult(MCity m  )  async {
    var row =  Row( children: await listCellForSingleRecord(m  ) );
    return Container( child:  row ,
        margin: EdgeInsets.symmetric(horizontal: DSDimen.space_level_1 )
    );
  }


  /**
   * the list horizontal to show data of record
   */
  Future<List<Widget>> listCellForSingleRecord(MCity m  ) async {

    List<Widget> list = [];

    list.add( cell_text( m.name_en, AdminDSDimen.header_width_l) );
    list.add( cell_text( m.name_ar, AdminDSDimen.header_width_l) );

    //id show to edit
    list.add( cell_id_primary( m.id, AdminDSDimen.header_width_m, () async {
      await  click_show_detail(m);
    }) );

    //delete
    list.add( cell_button("Trash", AdminDSDimen.header_width_m, () async {  await hidden_click(m);  }) );

    //fix table wrong sorting
   // sleep(Duration(milliseconds: 50 ));

    //log
    // Log.i( "listCellForSingleRecord() - id: " + m.id.toString() );
    // Log.i( "listCellForSingleRecord() - *************** "   );

    return list;
  }





}