import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/cart/data/model/MOrder.dart';
import 'package:umq/modules/cart/presentation/admin/list/c/ExtensionRowButtonController.dart';
import 'package:umq/modules/place/data/model/MCityTools.dart';
import 'package:umq/tools/resourceProject/ResourceDimenAdmin.dart';
import 'package:umq/tools/time/TimeTools.dart';
import 'package:umq/toolsUI/admin/itemRowTable/cell_id_primary.dart';
import 'package:umq/toolsUI/admin/itemRowTable/cell_price.dart';
import 'package:umq/toolsUI/admin/itemRowTable/cell_txt.dart';

import 'OrderListAdminPage.dart';

extension ExtenstionRow on OrderListAdminState {
  //--------------------------------------------------------------------  single row

  /**
   * single row to print "Record"
   */
  Future<Widget> rowItemResult(MOrder m) async {
    var row = Row(children: await listCellForSingleRecord(m));
    return Container(
        child: row,
        margin: EdgeInsets.symmetric(horizontal: DSDimen.space_level_1));
  }

  /**
   * the list horizontal to show data of record
   */
  Future<List<Widget>> listCellForSingleRecord(MOrder m) async {
    List<Widget> list = [];

    //id show to edit
    list.add(cell_id_primary(m.id, AdminDSDimen.header_width_m, () async {
      await click_show_detail(m);
    }));

    //price
    list.add(
        cell_price(double.parse(m.productPrice!), AdminDSDimen.header_width_m));
    list.add(
        cell_price(double.parse(m.vatPrice!), AdminDSDimen.header_width_m));
    list.add(cell_price(double.parse(m.net!), AdminDSDimen.header_width_m));

    //date
    String date = TimeTools.convertTimestamp_yyymmddhhmmPM(m.created!);
    list.add(cell_text(date, AdminDSDimen.header_width_l));

    //payment method
    String orderOnline = m.paymentOnlineId ?? "";
    if (ToolsValidation.isZero(orderOnline)) {
      orderOnline = "";
    }
    list.add(cell_text(m.paymentMethod.toString() + " " + orderOnline,
        AdminDSDimen.header_width_l));

    //shipping
    list.add(cell_text(m.user!.name!, AdminDSDimen.header_width_l));

    String cityName = MCityTools.getNameByLang(context, m.city);
    list.add(cell_text(cityName, AdminDSDimen.header_width_l));

    list.add(cell_text(m.addressDetail, AdminDSDimen.header_width_xl));

    //W   list.add( cell_text(  generateProductDetailText( m) , AdminDSDimen.header_width_xxx) );

    //fix table wrong sorting
    //sleep(Duration(milliseconds: 50 ));

    //log
    // Log.i( "listCellForSingleRecord() - id: " + m.id.toString() );
    // Log.i( "listCellForSingleRecord() - *************** "   );

    return list;
  }
}
