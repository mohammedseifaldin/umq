
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/cart/presentation/admin/detail/v/OrderDetailAdminPage.dart';
import 'package:umq/tools/time/TimeTools.dart';
 

extension HeaderOrderDetail on OrderDetailAdminState {

  Widget orderTitle() {
    var tv =  TextTemplate.t( "Order Information" ,
        levelDS: LevelDS.l1);

    return Container( child: tv  ,
      margin: EdgeInsets.only(top: DSDimen.space_level_1,
          left: DSDimen.space_level_2),
    );
  }


  Widget orderId() {
    var tv =  TextTemplate.t( "ID: #" + widget.mShow.id!.toString(),

        levelDS: LevelDS.l2);

    return Container( child: tv  ,
      margin: EdgeInsets.only(top: DSDimen.space_level_1,
          left: DSDimen.space_level_2),
    );
  }


  Widget orderDate(){
    String dateValue = TimeTools.convertTimestamp_yyymmddhhmmPM( widget.mShow.created!);

    var tv =  TextTemplate.t(  "Date: "  + dateValue,
        levelDS: LevelDS.l2);

    return Container( child:tv ,
      margin: EdgeInsets.only(
          top: DSDimen.space_level_3,
          left: DSDimen.space_level_2),
    );
  }








}