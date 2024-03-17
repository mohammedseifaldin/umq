import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/cart/presentation/admin/detail/v/OrderDetailAdminPage.dart';
import 'package:umq/tools/resourceProject/ResourceDimenAdmin.dart';

extension TableInvoice on OrderDetailAdminState {


  Widget titleProduct() {
    return Container( child: tv_titleProduct() ,
      margin: EdgeInsets.only(
          top: DSDimen.space_level_1,
          left: DSDimen.space_level_2),
    );
  }


  Widget tv_titleProduct(){
    return TextTemplate.t( "Products"  ,
        width: AdminDSDimen.inputFiled_title_width,
        levelDS: LevelDS.l1);
  }


  Widget getTableInvoice(){
    var tb = TableViewFastor( listRow , stateListener: (state) {
      tbState = state;
    });

    return Container( child:  tb,
      padding: EdgeInsets.only(top : DSDimen.space_level_3 ),
    );
  }
}