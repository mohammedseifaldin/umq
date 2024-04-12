import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/profile/data/model/m_user.dart';
import 'package:umq/tools/resourceProject/ResourceDimenAdmin.dart';
import 'package:umq/toolsUI/admin/itemRowTable/cell_button.dart';
import 'package:umq/toolsUI/admin/itemRowTable/cell_image_single.dart';
import 'package:umq/toolsUI/admin/itemRowTable/cell_txt.dart';
import 'package:umq/toolsUI/admin/picker/user/PickerUserPage.dart';
import 'package:umq/toolsUI/admin/picker/user/c/ExtensionRowButtonController.dart';
import 'package:universal_io/io.dart';

extension ExtenstionRowUser on PickerUserState {
  //--------------------------------------------------------------------  single row

  /**
   * single row to print "Record"
   */
  Future<Widget> rowItemResult(MUser m) async {
    var row = Row(children: await listCellForSingleRecord(m));
    return Container(
        child: row,
        margin: EdgeInsets.symmetric(horizontal: DSDimen.space_level_1));
  }

  /**
   * the list horizontal to show data of record
   */
  Future<List<Widget>> listCellForSingleRecord(MUser m) async {
    List<Widget> list = [];

    list.add(cell_button("Select", AdminDSDimen.header_width_m, () {
      click_selected(m);
    }));
    list.add(cell_image_single(m.photo, AdminDSDimen.header_width_s));
    list.add(cell_text(m.name, AdminDSDimen.header_width_l));
    list.add(cell_text(m.role, AdminDSDimen.header_width_m));
    list.add(cell_text(m.mobile, AdminDSDimen.header_width_m));

    //fix table wrong sorting
    sleep(Duration(milliseconds: 50));

    return list;
  }
}
