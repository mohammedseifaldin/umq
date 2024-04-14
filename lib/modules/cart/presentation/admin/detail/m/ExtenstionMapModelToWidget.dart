import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/cart/presentation/admin/detail/v/order_detail_admin_page.dart';
import 'package:umq/modules/cart/presentation/admin/detail/v/views/tableInvoice/ExtenstionColum.dart';
import 'package:umq/modules/cart/presentation/admin/detail/v/views/tableInvoice/ExtenstionRow.dart';
import 'package:umq/modules/cart/data/model/MOrderVendor.dart';

import 'package:umq/toolsUI/toast/ToastTools.dart';

extension ExtenstionMapModelToWidget on OrderDetailAdminState {
  Future mapModelToWidget() async {
    //list data
    var dataList = widget.mShow.arrayOrderVendor!;
    Log.i("mapModelToWidget() - dataList: " + dataList.length.toString());

    //check there is result after filter complete
    bool isNoResultFound = dataList.length == 0;
    if (isNoResultFound) {
      ToolsToast.i(context, "No Data Found");
      // now print
      tbState.updateList([]);
      return;
    }

    // //first add header
    Widget headerRow = columnHeader();
    listRow.add(headerRow);

    //now loop to generate widget
    int positionAtTable = 1;
    for (MOrderVendor m in dataList) {
      Widget w = await rowItemResult(m);
      listRow.add(w);
      //sleep( Duration( milliseconds: 10) );
      positionAtTable = positionAtTable + 1;
    }

    tbState.updateList(listRow);

    // // now print
    // setState(() {
    // });
  }
}
