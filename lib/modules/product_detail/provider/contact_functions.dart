import 'package:fastor_app_ui_widget/resource/toolsFastor/log/Log.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:umq/modules/product_detail/provider/product_details_notifier.dart';
import 'package:url_launcher/url_launcher.dart';

extension ContactFunctions on ProductDetailsNotifier {
  Future changeFavoriteStatus() async {
    ///TODO implement
    return;
    //  //check login
    //   if (await UserSingleTone.instance().isGuest()) {
    //     CheckoutLoginDialog.show(context);
    //     return;
    //   }

    //   / /change to
    //   var changeStatusTo = ToolsAPI.changeStatus(selectedProduct!.favorite!);
    //   setState(() {
    //     selectedProduct!.favorite = changeStatusTo;
    //   });

    //   ResponseGeneral response = await ApiHelper.apiHelper
    //       .favoriteApi(selectedProduct!.id!, changeStatusTo);

    //   Log.i("changeFavoriteStatus() - response: $response");

    //   if (ToolsAPI.isFailed(response.code)) {
    //     setState(() {
    //       var original = ToolsAPI.changeStatus(selectedProduct!.favorite!);
    //       selectedProduct!.favorite = original;
    //     });
  }

// postIncrement() async {
//   //check login
//   if (await UserSingleTone.instance().isGuest()) {
//     CheckoutLoginDialog.show(context);
//     return;
//   }

//   int productId = selectedProduct!.id ?? 0;
//   int providerId = selectedProduct!.provider!.id ?? 0;
//   String productName = MProductTools.getNameByLang(context, selectedProduct);
//   Log.i("postIncrement() productId: $productId /providerId: $providerId");

//   await CartChangeNotifier.getListenFalse(context)
//       .increment(context, productId, providerId, productName);

//   if (CartChangeNotifier.getListenFalse(context).responseCartCounter == null)
//     return;

//   //update counter
//   setState(() {
//     selectedProduct!.cartCounter = CartChangeNotifier.getListenFalse(context)
//         .responseCartCounter!
//         .newCounter!;
//   });

//   // //api
//   // new CartCounterApi().incrementCart( productId, providerId, (status, msg, response) {
//   //
//   //   //status
//   //   if( status == false ) {
//   //     //msg
//   //     ToolsToast.i(context, msg);
//   //     return;
//   //   }
//   //
//   //   //toast
//   //   String productName = MProductTools.getNameByLang(context, selectedProduct);
//   //   ToolsToast.i(context, '$productName Added To Cart');
//   //
//   //   //update counter
//   //   setState((){
//   //     selectedProduct!.cartCounter  = response.newCounter!;
//   //   });
//   //
//   // });
// }

// postDecrement() async {
//   //check login
//   if (await UserSingleTone.instance().isGuest()) {
//     CheckoutLoginDialog.show(context);
//     return;
//   }

//   int productId = selectedProduct!.id ?? 0;
//   int providerId = selectedProduct!.provider!.id ?? 0;
//   String productName = MProductTools.getNameByLang(context, selectedProduct);
//   Log.i("postDecrement() productId: $productId /providerId: $providerId");

//   await CartChangeNotifier.getListenFalse(context)
//       .decrement(context, productId, providerId, productName);

//   if (CartChangeNotifier.getListenFalse(context).responseCartCounter == null)
//     return;

//   //update counter
//   setState(() {
//     selectedProduct!.cartCounter = CartChangeNotifier.getListenFalse(context)
//         .responseCartCounter!
//         .newCounter!;
//   });

//   // //api
//   // new CartCounterApi().decrementCart( productId, providerId, (status, msg, response) {
//   //
//   //   //status
//   //   if( status == false ) {
//   //     //msg
//   //     ToolsToast.i(context, msg);
//   //     return;
//   //   }
//   //
//   //   //toast
//   //   String productName = MProductTools.getNameByLang(context, selectedProduct);
//   //   ToolsToast.i(context, '$productName Mines From Cart');
//   //
//   //   //update counter
//   //   setState((){
//   //     selectedProduct!.cartCounter  = response.newCounter!;
//   //   });
//   //
//   // });
// }

//-------------------------------------------  call

  Future openCallDirectly(String number) async {
    await FlutterPhoneDirectCaller.callNumber(number);
  }
//
//-------------------------------------------------- whats

  openwhatsapp(String phoneWithCountry) async {
    String msg = "Scuba-ksa.com\n\nHello";
    Log.i("openwhatsapp() phone: $phoneWithCountry /msg: $msg");
    await launchUrl(
      Uri.parse("https://wa.me/$phoneWithCountry?text=${Uri.parse(msg)}"),
    );
  }
}
