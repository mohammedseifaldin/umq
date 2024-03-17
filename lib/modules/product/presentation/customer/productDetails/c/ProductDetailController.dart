import 'dart:io';

import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:umq/modules/cart/data/source/CartCounterApi.dart';
import 'package:umq/modules/cart/data/response/ResponseCartCounter.dart';
import 'package:umq/tools/data/general/ResponseGeneral.dart';
import 'package:umq/modules/product/data/model/MProduct.dart';
import 'package:umq/modules/product/data/model/MProductTools.dart';
import 'package:umq/tools/network/BackendConstant.dart';
import 'package:umq/modules/product/presentation/customer/productDetails/m/ResponseProductDetail.dart';
import 'package:umq/modules/product/presentation/customer/productDetails/m/api_helper_detail.dart';

import 'package:umq/modules/product/presentation/customer/productDetails/m/utils.dart';
import 'package:umq/modules/product/presentation/customer/productDetails/view/ProductDetailView.dart';
import 'package:umq/modules/cart/provider/CartChangeNotifier.dart';
import 'package:umq/toolsUI/dialog/CheckoutLoginDialog.dart';
import 'package:umq/tools/cache/user_single_tone.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/tools/network/ToolsAPI.dart';
import 'package:umq/toolsUI/toast/ToastTools.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'package:flutter_share/flutter_share.dart';

extension ProductDetailController on ProductDetailState {
  Future getSingleProduct(int id) async {
    //  Log.i( "getSingleProduct() - progressCircleState: " + progressCircleState.toString() );
    //show
    if (progressCircleState != null) progressCircleState?.show();

    // await ApiHelper.apiHelper.singleProduct(id).then((value) {

    String url = BackendConstant.baseUrlv2Public + "/product/$id";
    String token = await UserSingleTone.instance().getToken();

    Map<String, String> header = NetworkHeaderTools.bearerToken(token);

    NetworkManagerDio().callBack(url, headers: header,
        callback: (status, msg, json) {
      ResponseProductDetail response = ResponseProductDetail.fromJson(json);

      //show
      if (progressCircleState != null) progressCircleState?.dismiss();

      Log.i("getSingleProduct() - response: " + response.toString());

      setState(() {
        selectedProduct = response.data;
      });
    });
  }

  Future changeFavoriteStatus() async {
    //check login
    if (await UserSingleTone.instance().isGuest()) {
      CheckoutLoginDialog.show(context);
      return;
    }

    //change to
    var changeStatusTo = ToolsAPI.changeStatus(selectedProduct!.favorite!);
    setState(() {
      selectedProduct!.favorite = changeStatusTo;
    });

    ResponseGeneral response = await ApiHelper.apiHelper
        .favoriteApi(selectedProduct!.id!, changeStatusTo);

    Log.i("changeFavoriteStatus() - response: " + response.toString());

    if (ToolsAPI.isFailed(response.code)) {
      setState(() {
        var original = ToolsAPI.changeStatus(selectedProduct!.favorite!);
        selectedProduct!.favorite = original;
      });
    }
  }

  postIncrement() async {
    //check login
    if (await UserSingleTone.instance().isGuest()) {
      CheckoutLoginDialog.show(context);
      return;
    }

    int productId = selectedProduct!.id ?? 0;
    int providerId = selectedProduct!.provider!.id ?? 0;
    String productName = MProductTools.getNameByLang(context, selectedProduct);
    Log.i("postIncrement() productId: " +
        productId.toString() +
        " /providerId: $providerId");

    await CartChangeNotifier.getListenFalse(context)
        .increment(context, productId, providerId, productName);

    if (CartChangeNotifier.getListenFalse(context).responseCartCounter == null)
      return;

    //update counter
    setState(() {
      selectedProduct!.cartCounter = CartChangeNotifier.getListenFalse(context)
          .responseCartCounter!
          .newCounter!;
    });

    // //api
    // new CartCounterApi().incrementCart( productId, providerId, (status, msg, response) {
    //
    //   //status
    //   if( status == false ) {
    //     //msg
    //     ToolsToast.i(context, msg);
    //     return;
    //   }
    //
    //   //toast
    //   String productName = MProductTools.getNameByLang(context, selectedProduct);
    //   ToolsToast.i(context, '$productName Added To Cart');
    //
    //   //update counter
    //   setState((){
    //     selectedProduct!.cartCounter  = response.newCounter!;
    //   });
    //
    // });
  }

  postDecrement() async {
    //check login
    if (await UserSingleTone.instance().isGuest()) {
      CheckoutLoginDialog.show(context);
      return;
    }

    int productId = selectedProduct!.id ?? 0;
    int providerId = selectedProduct!.provider!.id ?? 0;
    String productName = MProductTools.getNameByLang(context, selectedProduct);
    Log.i("postDecrement() productId: " +
        productId.toString() +
        " /providerId: $providerId");

    await CartChangeNotifier.getListenFalse(context)
        .decrement(context, productId, providerId, productName);

    if (CartChangeNotifier.getListenFalse(context).responseCartCounter == null)
      return;

    //update counter
    setState(() {
      selectedProduct!.cartCounter = CartChangeNotifier.getListenFalse(context)
          .responseCartCounter!
          .newCounter!;
    });

    // //api
    // new CartCounterApi().decrementCart( productId, providerId, (status, msg, response) {
    //
    //   //status
    //   if( status == false ) {
    //     //msg
    //     ToolsToast.i(context, msg);
    //     return;
    //   }
    //
    //   //toast
    //   String productName = MProductTools.getNameByLang(context, selectedProduct);
    //   ToolsToast.i(context, '$productName Mines From Cart');
    //
    //   //update counter
    //   setState((){
    //     selectedProduct!.cartCounter  = response.newCounter!;
    //   });
    //
    // });
  }

  //-------------------------------------------  call

  Future openCallDirectly(String number) async {
    await FlutterPhoneDirectCaller.callNumber(number);
  }
//
  //-------------------------------------------------- whats

  openwhatsapp(String phoneWithCountry) async {
    String msg = "Scuba-ksa.com" + "\n\n" + "Hello";
    Log.i("openwhatsapp() phone: " +
        phoneWithCountry.toString() +
        " /msg: " +
        msg);
    if (Platform.isIOS) {
      await launch("https://wa.me/$phoneWithCountry?text=${Uri.parse(msg)}",
          forceSafariVC: false);
    } else {
      await launch("whatsapp://send?phone=$phoneWithCountry&text=" + msg);
    }
  }

  // void launchWhatsApp(number, message) async {
  //   Log.i( "launchWhatsApp: " + number.toString() + " /msg: " + message );
  //   final link = WhatsAppUnilink(
  //     phoneNumber: number,
  //     text: message,
  //   );
  //
  //   await launch('$link');
  // }

  //------------------------------------------------------------- dynamic linke
}
