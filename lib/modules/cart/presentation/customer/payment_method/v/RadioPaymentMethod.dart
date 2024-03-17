import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/cart/presentation/customer/payment_method/c/CartPaymentMethodController.dart';

import 'package:umq/modules/cart/presentation/customer/payment_method/v/CartPaymentMethodPage.dart';
import 'package:umq/tools/constant/EPaymentMethod.dart';
import 'package:umq/tools/resourceProject/ColorProject.dart';

extension RadioPaymentMethod on CartPaymentMethodState {


  //---------------------------------------------------------------- method

  Widget tvSelectPaymentMethod() {
    return TextTemplate.t(
        "Select payment method",
        levelDS: LevelDS.l2,
        margin: EdgeInsets.only(
            top: DSDimen.space_level_1,
            bottom: DSDimen.space_level_2

        ),
        gravityLayoutAlign: Alignment.center
    );
  }


  Widget radioGroup_method() {
    var column =  ColumnTemplate.t( children : [

      _rdCash(),
      sepratorCardLine(),
      _rdOnline()
    ]
    );

    return Container( child: column,
      decoration: BoarderHelper.cardView(),
      margin: EdgeInsets.all(DSDimen.space_level_2),
      padding: EdgeInsets.all( DSDimen.space_level_2 ),
    );
  }


  Widget _rdCash(){
    return RadioTemplate.t(context,
        radioSpecialValue: EPaymentMethod.cash.name ,
       // colorBackground: Colors.yellow,
        decoration: BoarderHelper.rounded(
          colorBackground: Colors.white
        ),
        padding: EdgeInsets.all(5),
        groupValue: groupValue_method,
        text: "Cash on delivery", //"Cash on delivery",
        onChange: (String s){
          handlerRadio_paymentMethod( EPaymentMethod.cash.name  );
        });
  }


  Widget _rdOnline(){
    return RadioTemplate.t(context,
        radioSpecialValue: EPaymentMethod.online.name ,
        groupValue: groupValue_method,
        decoration: BoarderHelper.rounded(
            colorBackground: Colors.white
        ),
        padding: EdgeInsets.all(5),
        text:  "Online Payment", // "Bank transfer",
        onChange: (String s){
          handlerRadio_paymentMethod(  EPaymentMethod.online.name );
        });
  }

  //------------------------------------------------------------ line

  Widget sepratorCardLine(){
    return Container(
      width: DeviceTools.getWidth(context),
      height: 2,
      margin: EdgeInsets.symmetric( vertical: DSDimen.space_level_3),
      color: HexColor( ColorProject.blue_fish_front),
    );
  }

}