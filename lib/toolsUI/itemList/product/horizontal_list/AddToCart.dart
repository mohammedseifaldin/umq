
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:umq/modules/cart/data/source/CartCounterApi.dart';
import 'package:umq/modules/product/data/model/MProduct.dart';
import 'package:umq/modules/product/data/model/MProductTools.dart';
import 'package:umq/modules/favorite/data/source/FavoriteTeacherApi.dart';
import 'package:umq/modules/cart/provider/CartChangeNotifier.dart';
import 'package:umq/tools/navigate/GoTo.dart';
import 'package:umq/tools/resourceProject/ColorProject.dart';
import 'package:umq/toolsUI/app_colors.dart';
import 'package:umq/toolsUI/dialog/CheckoutLoginDialog.dart';
import 'package:umq/toolsUI/snack_bar.dart';
import 'package:umq/tools/cache/user_single_tone.dart';
import 'package:umq/toolsUI/toast/ToastTools.dart';

import 'ItemProductHorizontal.dart';


extension ItemProductHorizontalController on ItemProductHorizontal {

  // Widget consumerCart(){
  //
  //   return Consumer<CartChangeNotifier>(builder: ( _, notifier, child ){
  //     return clickCartWidget();
  //   });
  // }

  Widget  clickCartWidget(){
    Widget paddingWithIcon = Padding(
        padding: EdgeInsets.all(10),
        child:  icon_shopping()
    );

    return   InkWell(
        onTap: () async {
          await addProductToCart(
              mProduct , pageContext);
        },
        child: paddingWithIcon
    );
  }

  Future addProductToCart(MProduct mProduct, context) async  {


    //check login
    if( await UserSingleTone.instance().isGuest() ) {
      CheckoutLoginDialog.show(context);
      return;
    }

    int productId = mProduct.id??0;
    int providerId = mProduct.provider?.id??0;
    String productName = MProductTools.getNameByLang(context, mProduct);
    await CartChangeNotifier.getListenFalse(context).increment(context, productId, providerId, productName);

    // //api
    // new CartCounterApi().incrementCart( mProduct.id??0, providerId, (status, msg, response) {
    //
    //   //status
    //   if( status == false ) {
    //     //msg
    //     ToolsToast.i(context, msg);
    //     return;
    //   }
    //   ToolsToast.i(context, '$productName Added To Cart');
    // });

  }



}