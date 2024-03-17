
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';

import 'package:umq/toolsUI/admin/itemRowTable/cell_button.dart';
import 'package:umq/toolsUI/admin/itemRowTable/cell_id_primary.dart';
import 'package:umq/toolsUI/admin/itemRowTable/cell_price.dart';

import 'package:umq/toolsUI/admin/itemRowTable/cell_txt.dart';


import 'package:umq/tools/resourceProject/ResourceDimenAdmin.dart';

import 'package:umq/modules/subscribe/data/model/MSubscribePackage.dart';
import 'package:umq/modules/subscribe/presentation/admin/package_list/widget/ExtensionRowButtonController.dart';


import 'package:umq/modules/subscribe/presentation/admin/package_list/SubscribePackageListAdminPage.dart';


extension ExtenstionRow on SubscribePackageListAdminPageState {


  //--------------------------------------------------------------------  single row

  /**
   * single row to print "Record"
   */
   Widget  rowItemResult(MSubscribePackage m  )    {
    var row =  Row( children:   listCellForSingleRecord(m  ) );
    return Container( child:  row ,
        margin: EdgeInsets.symmetric(horizontal: DSDimen.space_level_1 )
    );
  }


  /**
   * the list horizontal to show data of record
   */
   List<Widget>  listCellForSingleRecord(MSubscribePackage m  )   {

    List<Widget> list = [];

    list.add( cell_text( m.nameEn, AdminDSDimen.header_width_l) );
    list.add( cell_text( m.nameAr, AdminDSDimen.header_width_l) );

    //price
    double parsePrice =  double.parse(m.price.toString() +  ".00");
    list.add( cell_price( parsePrice, AdminDSDimen.header_width_m) );

    //period
    list.add( cell_text( m.period.toString(), AdminDSDimen.header_width_m) );

    //id show to edit
    list.add( cell_id_primary( m.id, AdminDSDimen.header_width_m, () async {
      await  click_show_detail(m);
    }) );

    //delete
    list.add( cell_button("Trash", AdminDSDimen.header_width_m, () async {  await hidden_click(m);  }) );
    return list;
  }





}