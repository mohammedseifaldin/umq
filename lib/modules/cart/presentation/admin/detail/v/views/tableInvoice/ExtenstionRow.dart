import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/cart/data/model/MOrderVendor.dart';
import 'package:umq/modules/cart/presentation/admin/detail/v/OrderDetailAdminPage.dart';
import 'package:umq/modules/product/data/model/MProductTools.dart';
import 'package:umq/tools/resourceProject/ResourceDimenAdmin.dart';
import 'package:umq/toolsUI/admin/itemRowTable/cell_price.dart';
import 'package:umq/toolsUI/admin/itemRowTable/cell_txt.dart';

extension ExtenstionRow on OrderDetailAdminState {
  //--------------------------------------------------------------------  single row

  /**
   * single row to print "Record"
   */
  Future<Widget> rowItemResult(MOrderVendor m) async {
    var row = Row(children: await listCellForSingleRecord(m));
    return Container(
        child: row,
        margin: EdgeInsets.symmetric(horizontal: DSDimen.space_level_1));
  }

  /**
   * the list horizontal to show data of record
   */
  Future<List<Widget>> listCellForSingleRecord(MOrderVendor m) async {
    List<Widget> list = [];

    //product info
    list.add(cell_text(m.productId.toString(), AdminDSDimen.header_width_m));
    String nameProduct = MProductTools.getNameByLang(context, m.product);
    list.add(cell_text(nameProduct, AdminDSDimen.header_width_l));
    list.add(
        cell_price(double.parse(m.productPrice!), AdminDSDimen.header_width_m));
    list.add(cell_text(m.productQty.toString(), AdminDSDimen.header_width_m));

    //vendor info
    String nameVendor = m.mProvider!.users!.name!;
    list.add(cell_text(nameVendor, AdminDSDimen.header_width_l));
    String phoneVendor = m.mProvider!.users!.mobile!;
    list.add(cell_text(phoneVendor, AdminDSDimen.header_width_l));

    //fix table wrong sorting
    // sleep(Duration(milliseconds: 50 ));

    return list;
  }
}
