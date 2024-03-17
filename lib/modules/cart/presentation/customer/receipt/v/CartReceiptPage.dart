
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';

import 'package:umq/modules/cart/presentation/customer/receipt/c/CartReceiptController.dart';
import 'package:umq/modules/cart/presentation/customer/receipt/v/PaymentInfoReceipt.dart';
import 'package:umq/modules/cart/presentation/customer/receipt/v/ShippingInfoReceipt.dart';
import 'package:umq/modules/cart/data/response/ResponseCartProductList.dart';
import 'package:umq/toolsUI/ToolbarCart/ToolbarCart.dart';
import 'package:umq/toolsUI/buttons/BlueBlurButtonScuba.dart';
import 'package:umq/tools/resourceProject/ColorProject.dart';

class CartReceiptPage extends StatefulWidget {

  @override
  CartReceiptState createState() {
    return CartReceiptState();
  }

}

class CartReceiptState extends State<CartReceiptPage> {


  bool showDialogSuccessCreateOrder = false;

  ResponseCartProductList? response ;

  bool progress = false;

  //---------------------------------------------------------------------- life style

  @override
  void initState() {
    super.initState();
    getCartListApi();
  }

  //---------------------------------------------------------------------- build

  @override
  Widget build(BuildContext context) {
    return PageTemplate.t( this ,
      content: getContent(),
      //toolbar
      toolbar: ToolbarCartView(  context, "Receipt", 3 ),
      toolbar_height: ToolbarCartView.frameHeight,

    );
  }

  //------------------------------------------------------------------ content

  Widget getContent() {

    var contentPage =  ColumnTemplate.t(
        width: DeviceTools.getWidth(context),
        alignGravity: Alignment.topCenter  ,
        children: [
          orderDetiailShippingInformation(),
          orderDetailPaymentInformation(),

          //button
          btNext()

        ]);

    if( progress ) {
      return showProgress();
    }

    // return Stack( children: [
    //
    // ],);

    return contentPage;
  }

  Widget showProgress() {
    return ProgressSpinkit.centerPage(context);
  }

  //-------------------------------------------------------------------- tools ui

  Widget separator() {
    return Container( width: DeviceTools.getWidth(context),
      height: 2,
      color: HexColor( ColorProject.blueTransparent_fish_front ),
      margin: EdgeInsets.symmetric( vertical: DSDimen.space_level_2),
    );
  }

  //-------------------------------------------------------------------- next

  Widget btNext() {
    String title =   'Confirm Order';
    var bt =  BlueBlurButtonScuba(title, DeviceTools.getWidth(context), 50, () async {
      await clickNext();

    } );

    return Container( child: bt,
        margin: EdgeInsets.only(top: DSDimen.space_level_1 ,
          bottom: DSDimen.space_level_1,
            left: DSDimen.space_level_2,
            right: DSDimen.space_level_2

        )
    );
  }

}