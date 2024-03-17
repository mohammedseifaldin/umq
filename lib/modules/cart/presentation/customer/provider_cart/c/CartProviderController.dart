import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/modules/cart/data/model/MCartSingleProduct.dart';
import 'package:umq/modules/cart/data/source/CartListAPI.dart';
import 'package:umq/modules/cart/data/source/CartProviderListAPI.dart';
import 'package:umq/modules/cart/presentation/customer/main/v/views/totalBar/v/TotalPriceBarView.dart';
import 'package:umq/modules/cart/presentation/customer/provider_cart/v/CartProviderScreen.dart';
import 'package:umq/modules/cart/provider/CartChangeNotifier.dart';
import 'package:umq/modules/cart/shared/OrderCurrentSingletone.dart';
import 'package:umq/modules/product/data/model/MProductTools.dart';
import 'package:umq/tools/cache/user_single_tone.dart';
import 'package:umq/tools/constant/ConstantProject.dart';
import 'package:umq/tools/navigate/GoTo.dart';
import 'package:umq/toolsUI/toast/ToastTools.dart';

extension CartProviderController on CartProviderState {
  //-------------------------------------------------------------------------- get cart

  Future getCartListApi() async {
    //check guest
    bool isGuestType = await UserSingleTone.instance().isGuest();
    if (isGuestType) {
      setState(() {
        isGuest = true;
      });
      return;
    }

    //progress
    setState(() {
      progress = true;
    });

    //api
    _apiListener();
  }

  void _apiListener() async {
    await CartProviderListAPI().getData((status, msg, response) async {
      //set
      setState(() {
        this.response = response;
        progress = false;
      });

      //check status
      if (status == false) {
        ToolsToast.i(context, msg);
        return;
      }
    });
  }

  //------------------------------------------------------------ cancel

  Future cancelClick(MCartSingleProduct mCart) async {
    //progress
    setState(() {
      progress = true;
    });

    int productId = mCart.productId!;
    int providerId = mCart.product?.provider?.id ?? 0;
    String productName = MProductTools.getNameByLang(context, mCart.product);
    await CartChangeNotifier.getListenFalse(context)
        .cancel(context, productId, providerId, productName);

    //progress
    setState(() {
      progress = false;
    });

    //refresh api get list
    getCartListApi();

    // //api
    // new CartCounterApi().cancel( productId, providerId, (status, msg, response) {
    //
    //
    //   //status
    //   if( status == false ) {
    //     //progress
    //     setState((){
    //       progress = false;
    //     });
    //
    //     //msg
    //     ToolsToast.i(context, msg);
    //     return;
    //   }
    //
    //   //refresh api get list
    //   getCartListApi();
    //
    // });
  }

  //------------------------------------------------------------------------ totalBar update

  Future updateTotalApi() async {
    var responseListProduct = await CartListAPI().getData();

    if (responseListProduct != null) {
      totalPriceState!.updateTotalPrice(responseListProduct.totalPrice!);
    }
    //
    // await CartListAPI().getData((status, msg, response) async {
    //
    //   if( status == false ) return;
    //
    //   totalPriceState!.updateTotalPrice( response.totalPrice! );
    //
    // });
  }

  //---------------------------------------------------------------------- next click

  Future clickNext(String totalPrice) async {
    //remove old data
    OrderCurrentSingletone.instance().initializeVariable();

    //validate
    if (validateCheckout(totalPrice) == false) return;

    Log.i("clickNext() - response!.data!: " + response!.data!.toString());

    //save data
    // OrderCurrentSingletone.instance().cartList = response!.data!;
    // OrderCurrentSingletone.instance().priceProductTotal =  totalPrice;

    //next
    GoTo.cartShipmentPage(context);
  }

  bool validateCheckout(String totalPrice) {
    double v = double.parse(totalPrice);
    if (v < ConstantProject.priceMinOrder) {
      ToolsToast.i(context, "Price must not be less than 40 Pound");
      return false;
    }
    return true;
  }
}
