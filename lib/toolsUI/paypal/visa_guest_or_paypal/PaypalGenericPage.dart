

import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';

import 'package:umq/toolsUI/paypal/visa_guest_or_paypal/logic/CheckerPaymentStatusComplete.dart';
import 'package:umq/toolsUI/paypal/visa_guest_or_paypal/shared/PayPalConstant.dart';
import 'package:umq/toolsUI/paypal/visa_guest_or_paypal/shared/ToolsPayment.dart';
import 'package:umq/toolsUI/paypal/visa_guest_or_paypal/widget/webviewPayment/WebviewPaymentPage.dart';

typedef PaypalCallBack = Function(bool status, String msg , String orderId );

class PaypalGenericPage extends StatefulWidget {

  double price;
  PaypalCallBack payPalCallBack;

  PaypalGenericPage( {
    required this.price,
    required this.payPalCallBack
  });

  @override
  PaypalGenericState createState() {
    // TODO: implement createState
    return PaypalGenericState( this.price, payPalCallBack:  this.payPalCallBack);
  }


}

class PaypalGenericState extends State<PaypalGenericPage> {

  //-------------------------------------------------------------------- varaible



  // webview payment
  String urlChangeTo = "";
  String linkToPay = "";

  //status complete transaction
  bool isTransactionSuccess = false;

  //transaction info
  String transactionId = "";


  String transactionFailedMessage = "Payment Not completed";

  //------------------------------------------------------------------- constructor

  double price;
  PaypalCallBack? payPalCallBack;

  PaypalGenericState(this.price, {
    required PaypalCallBack this.payPalCallBack
  }){

    /**
     * test mode price 1 dollar
     */
    if( PayPalConstant.forcePriceIsOneDollar){
      this.price = 1;
    }
    generateLinkToPay();

  }

  //----------------------------------------------------------------- default

  void generateLinkToPay(){
    linkToPay = PayPalConstant.linkToPayBaseWithPrice + price.toString();
  }

  //---------------------------------------------------------------------- lifecycle

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  //-------------------------------------------------------------------- build

  late BuildContext context  ;

  @override
  Widget build(BuildContext context) {
    print("paypal - PaypalGenericState - build");
    this.context = context;

    var stack = Stack( children: [

      //all screen size
        Placeholder(strokeWidth: 0, color: Colors.transparent ,
            fallbackWidth: ToolsPayment.getWidth( context, ""),
            fallbackHeight: ToolsPayment.getHeight( context, "") ) ,

        //webview
      webviewPayment(),


    ] );

    return Container( child: stack,
    color: Colors.white,);
  }

  //----------------------------------------------------------------- webview

  Widget webviewPayment(){
     return WebviewPaymentPage(
        url :  linkToPay  ,
        urlChange: (urlChange ) async {
          this.urlChangeTo = urlChange;
          await checkThisUrlForCompleteStatus(urlChangeTo);
        });
  }





}