import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/modules/cart/data/model/MapCurrentOrderToNewOrderRequest.dart';
import 'package:umq/modules/cart/data/request/OrderRequest.dart';
import 'package:umq/modules/cart/data/source/CartListAPI.dart';
import 'package:umq/modules/cart/data/source/OrderCreateAPI.dart';
import 'package:umq/modules/cart/presentation/customer/receipt/c/PaymentMethodAtReceiptController.dart';
import 'package:umq/modules/cart/presentation/customer/receipt/v/CartReceiptPage.dart';
import 'package:umq/modules/cart/presentation/customer/receipt/v/DialogSuccessOrder.dart';
import 'package:umq/modules/cart/shared/CartUtils.dart';
import 'package:umq/modules/cart/shared/OrderCurrentSingletone.dart';
import 'package:umq/tools/constant/ConstantProject.dart';
import 'package:umq/toolsUI/toast/ToastTools.dart';

extension CartReceiptController on CartReceiptState {
  //--------------------------------------------------------------------- get cart dat

  Future getCartListApi() async {
    //progress
    setState(() {
      progress = true;
    });

    //api
    _apiListener();
  }

  Future _apiListener() async {
    this.response = await CartListAPI().getData();

    //set
    setState(() {
      this.response = response;
      progress = false;
    });

    if (response != null) {
      //set the current list cart
      OrderCurrentSingletone.instance().cartList = response!.data!;
    } else {
      ToolsToast.i(context, "Refresh The Page");
    }

    // await CartListAPI().getData((status, msg, response) async {
    //
    //   //set
    //   setState((){
    //     this.response = response;
    //     progress = false;
    //   });
    //
    //   //check status
    //   if( status == false ) {
    //     ToolsToast.i(context, msg);
    //     return ;
    //   }
    //
    //   //set the current list cart
    //   OrderCurrentSingletone.instance().cartList = response.data!;
    // });
  }

  //--------------------------------------------------------------------- next button

  Future clickNext() async {
    if (_validateBeforeCreateNewOrder() == false) return;

    //choose type
    chooseTypePaymentMethod();
  }

  bool _validateBeforeCreateNewOrder() {
    //case address
    String address = OrderCurrentSingletone.instance().address;
    bool isAddressEmpty = ToolsValidation.isEmpty(address);
    if (isAddressEmpty) {
      ToolsToast.i(context, "Address missed");
      return false;
    }

    //city
    var city = OrderCurrentSingletone.instance().city;
    if (city == null) {
      ToolsToast.i(context, "City not selected");
      return false;
    }

    // payment method
    var method = OrderCurrentSingletone.instance().paymentMethod;
    if (ToolsValidation.isEmpty(method)) {
      ToolsToast.i(context, "Payment method not selected");
      return false;
    }

    //check total not zero
    double total = OrderCurrentUtils.totalInvoice();
    if (total == 0) {
      ToolsToast.i(context, "Total price Order is Zero not allowed");
      return false;
    }

    //check total less than min
    if (total < ConstantProject.priceMinOrder) {
      ToolsToast.i(context, "Price must not be less than 40 Pound");
      return false;
    }

    //default success
    return true;
  }

  void apiCreateOrder() async {
    //progress
    setState(() {
      progress = true;
    });

    //map data
    OrderRequest request =
        await MapCurrentOrderToNewOrderRequest.generateFromCurrentOrder(
            context);

    //api
     OrderCreateAPI().create(request, (status, msg, response) {
      //progress
      setState(() {
        progress = false;
      });

      //check
      if (status == false) {
        ToolsToast.i(context, msg);
        return;
      }

      //dialog success
      showDialogSuccess(response);
    });
  }
}
