import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/cart/presentation/customer/payment_method/v/CartPaymentMethodPage.dart';

@Deprecated( "No shipment company needed any more")
extension CartShipmentCompany on CartPaymentMethodState {

  Widget tvSelectShipmentCompany(){
    return TextTemplate.t(
        "Select Shipment Company",
        levelDS: LevelDS.l2,
        margin: EdgeInsets.only(
            top: DSDimen.space_level_1,
            bottom: DSDimen.space_level_2

        ),
        gravityLayoutAlign: Alignment.center
    );
  }


}