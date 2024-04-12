import 'package:umq/modules/cart/data/model/MCartSingleProduct.dart';
import 'package:umq/modules/cart/presentation/customer/main/c/MainCartController.dart';
import 'package:umq/modules/cart/presentation/customer/main/v/views/itemProduct/v/ItemProductCartView.dart';
import 'package:umq/modules/cart/provider/CartChangeNotifier.dart';
import 'package:umq/modules/favorite/data/source/FavoriteProductApi.dart';
import 'package:umq/modules/product/data/model/MProductTools.dart';
import 'package:umq/tools/network/ToolsAPI.dart';
import 'package:umq/toolsUI/toast/ToastTools.dart';

extension ItemProductCartController on ItemProductCartState {
  //---------------------------------------------------------------------- plus / mines

  Future incrementClick(MCartSingleProduct mCart) async {
    ///progress
    setState(() {
      progressPlusMines = true;
    });

    int productId = mCart.productId!;
    int providerId = mCart.product?.provider?.id ?? 0;

    String productName = MProductTools.getNameByLang(context, mCart.product);
    await CartChangeNotifier.getListenFalse(context)
        .increment(context, productId, providerId, productName);

    if (CartChangeNotifier.getListenFalse(context).responseCartCounter ==
        null) {
      ///progress
      setState(() {
        progressPlusMines = false;
      });
      return;
    }

    //update counter
    setState(() {
      progressPlusMines = false;
      counterCurrent = CartChangeNotifier.getListenFalse(context)
          .responseCartCounter!
          .newCounter!;
    });

    //update total
    widget.parentState.updateTotalApi();
  }

  Future decrementClick(MCartSingleProduct mCart) async {
    ///progress
    setState(() {
      progressPlusMines = true;
    });

    int productId = mCart.productId!;
    int providerId = mCart.product?.provider?.id ?? 0;

    String productName = MProductTools.getNameByLang(context, mCart.product);
    await CartChangeNotifier.getListenFalse(context)
        .decrement(context, productId, providerId, productName);

    if (CartChangeNotifier.getListenFalse(context).responseCartCounter ==
        null) {
      ///progress
      setState(() {
        progressPlusMines = false;
      });
      return;
    }

    //update counter
    setState(() {
      progressPlusMines = false;
      counterCurrent = CartChangeNotifier.getListenFalse(context)
          .responseCartCounter!
          .newCounter!;
    });

    //update total
    widget.parentState.updateTotalApi();
  }

  //---------------------------------------------------------------------- favorite

  Future favoriteClick(MCartSingleProduct mCart) async {
    int productId = mCart.productId!;

    int newStatusFavorite = ToolsAPI.changeStatus(isFavorite);
    //api
    FavoriteProductApi().changeStatus(productId, newStatusFavorite,
        (status, msg) {
      //status
      if (status == false) {
        //msg
        ToolsToast.i(context, msg);
        return;
      }

      //refresh api get list
      setState(() {
        isFavorite = newStatusFavorite;
      });
    });
  }
}
