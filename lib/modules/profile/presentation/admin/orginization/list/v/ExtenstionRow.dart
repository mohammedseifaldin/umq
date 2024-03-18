import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/profile/data/model/MOrganization.dart';
import 'package:umq/modules/profile/presentation/admin/orginization/list/c/ExtensionRowButtonController.dart';
import 'package:umq/tools/resourceProject/ResourceDimenAdmin.dart';
import 'package:umq/toolsUI/admin/itemRowTable/cell_button.dart';
import 'package:umq/toolsUI/admin/itemRowTable/cell_id_primary.dart';
import 'package:umq/toolsUI/admin/itemRowTable/cell_txt.dart';

import 'OrgListAdminPage.dart';

extension ExtenstionRow on OrgListAdminState {
  //--------------------------------------------------------------------  single row

  // single row to print "Record"

  Future<Widget> rowItemResult(MOrganization m) async {
    var row = Row(children: await listCellForSingleRecord(m));
    return Container(
        margin: EdgeInsets.symmetric(horizontal: DSDimen.space_level_1),
        child: row);
  }

  // the list horizontal to show data of record

  Future<List<Widget>> listCellForSingleRecord(MOrganization m) async {
    List<Widget> list = [];

    list.add(cell_text(m.name, AdminDSDimen.header_width_l));
    // list.add( cell_text( m.name_ar, AdminDSDimen.header_width_l) );

    //id show to edit
    list.add(cell_id_primary(m.id, AdminDSDimen.header_width_m, () async {
      await click_show_detail(m);
    }));

    //delete
    list.add(cell_button("Trash", AdminDSDimen.header_width_m, () async {
      await hidden_click(m);
    }));

    //fix table wrong sorting
    //  sleep(Duration(milliseconds: 50 ));

    //log
    // Log.i( "listCellForSingleRecord() - id: " + m.id.toString() );
    // Log.i( "listCellForSingleRecord() - *************** "   );

    return list;
  }
}
