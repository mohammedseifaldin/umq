import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/cart/presentation/admin/detail/v/order_detail_admin_page.dart';

import 'package:umq/tools/resourceProject/ResourceDimenAdmin.dart';

extension ExtenstionColum on OrderDetailAdminState {
  Widget columnHeader() {
    var row = Row(children: cellHeaderList());
    //   return EmptyView.colored( 500 , 50, Colors.orange );

    return Container(
        child: row,
        margin: EdgeInsets.symmetric(horizontal: DSDimen.space_level_1));
  }

  //-------------------------------------------------------------------- map to widget

  List<Widget> cellHeaderList() {
    List<Widget> list = [];
    list.add(getHeaderCell("Product ID", AdminDSDimen.header_width_m));
    list.add(getHeaderCell("Product Name", AdminDSDimen.header_width_l));
    list.add(getHeaderCell("Product Price", AdminDSDimen.header_width_m));
    list.add(getHeaderCell("Product Qty", AdminDSDimen.header_width_m));
    list.add(getHeaderCell("Vendor Name", AdminDSDimen.header_width_l));
    list.add(getHeaderCell("Vendor Phone", AdminDSDimen.header_width_l));
    return list;
  }

  //-------------------------------------------------------------------- header cell

  Widget getHeaderCell(String s, double width) {
    //stack
    return Stack(children: [box(width), txt(s, width)]);
  }

  Widget txt(String s, double width) {
    return TextTemplate.t(s,
        levelDS: LevelDS.l2,
        // color: ResourceColorAdmin.table_header_title,
        color: DSColor.table_header_title,
        padding: EdgeInsets.only(left: 5),
        width: width,
        height: AdminDSDimen.header_height_m,
        gravityLayoutAlign: Alignment.center);
  }

  Widget box(double width) {
    return Container(
      width: width,
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
