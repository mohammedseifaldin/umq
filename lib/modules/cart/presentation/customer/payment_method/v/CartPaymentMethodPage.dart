import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/cart/presentation/customer/payment_method/c/CartPaymentMethodController.dart';
import 'package:umq/modules/cart/presentation/customer/payment_method/v/RadioPaymentMethod.dart';
import 'package:umq/toolsUI/ToolbarCart/ToolbarCart.dart';
import 'package:umq/toolsUI/buttons/BlueBlurButtonScuba.dart';

class CartPaymentMethodPage extends StatefulWidget {
  const CartPaymentMethodPage({super.key});

  @override
  CartPaymentMethodState createState() {
    return CartPaymentMethodState();
  }
}

class CartPaymentMethodState extends State<CartPaymentMethodPage> {
  //---------------------------------------------------------------------- variable

  var groupValue_method = ""; // EPaymentMethod.cash.name ;

  //---------------------------------------------------------------------- life style

  @override
  void initState() {
    super.initState();

    //set edit
    setEditPaymentMethod();
  }

  //---------------------------------------------------------------------- build

  @override
  Widget build(BuildContext context) {
    Log.i("build() - groupValue_method: " + groupValue_method.toString());

    return PageTemplate.t(
      this,
      content: getContent(),
      //fixed background
      //widgetBackground: BackgroundCardPage( toolbarHeight: ToolbarProjectBack.frameHeight ),
      //toolbar
      toolbar: ToolbarCartView(context, "Payment", 2),
      toolbar_height: ToolbarCartView.frameHeight,
    );
  }

  //------------------------------------------------------------------ content

  Widget getContent() {
    return ColumnTemplate.t(
        width: DeviceTools.getWidth(context),
        alignGravity: Alignment.topCenter,
        children: [
          //method
          tvSelectPaymentMethod(),
          radioGroup_method(),

          //shipment
          //tvSelectShipmentCompany()

          //button
          btNext()
        ]);
  }

  Widget btNext() {
    String title = 'Next';
    var bt =
        BlueBlurButtonScuba(title, DeviceTools.getWidth(context), 50, () async {
      await clickNext();
    });

    return Container(
        child: bt,
        margin: EdgeInsets.only(
            top: DSDimen.space_level_1,
            bottom: DSDimen.space_level_1,
            left: DSDimen.space_level_2,
            right: DSDimen.space_level_2));
  }
}
