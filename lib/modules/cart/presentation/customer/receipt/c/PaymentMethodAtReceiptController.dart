import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/modules/cart/data/model/MapCurrentOrderToNewOrderRequest.dart';
import 'package:umq/modules/cart/data/request/OrderRequest.dart';
import 'package:umq/modules/cart/data/source/OrderCreateAPI.dart';
import 'package:umq/modules/cart/presentation/customer/receipt/v/CartReceiptPage.dart';
import 'package:umq/modules/cart/presentation/customer/receipt/v/DialogSuccessOrder.dart';
import 'package:umq/modules/cart/shared/CartUtils.dart';
import 'package:umq/modules/cart/shared/OrderCurrentSingletone.dart';
import 'package:umq/tools/navigate/GoTo.dart';
import 'package:umq/toolsUI/toast/ToastTools.dart';

extension PaymentMethodAtReceiptController on CartReceiptState {
  //----------------------------------------------------------------------- choose type payment method

  Future chooseTypePaymentMethod() async {
    //case online not completed
    bool isOnline =
        OrderCurrentSingletone.instance().isPaymentMethodTypeOnline();
    if (isOnline) {
      await openPagePaymentOnline();
    } else {
      await apiCreateOrder();
    }
  }

  //----------------------------------------------------------------------- online payment

  Future openPagePaymentOnline() async {
    double total = OrderCurrentUtils.totalInvoice();
    GoTo.onlinePaymentPayPal(
        context: context,
        price: total,
        callback: (bool status, String msg, String orderId) {
          Log.i("openPagePaymentOnline() - status: $status /orderId: $orderId");

          if (status) {
            setInfomationPaymentMethodPaypalSuccess(orderId);
            apiCreateOrder();
          } else {
            ToolsToast.i(context, "PayPal Payment Not Complete");
          }
        });
  }

  bool isVailedOnlinePaymentMethod() {
    //case online not completed
    bool isOnline =
        OrderCurrentSingletone.instance().isPaymentMethodTypeOnline();
    if (isOnline) {
      bool isSuccessOnline =
          OrderCurrentSingletone.instance().onlinePayment_status;
      if (isSuccessOnline == false) {
        ToolsToast.i(context, "Payment online failed");
        return false;
      }
    }
    return isOnline;
  }

  //----------------------------------------------------------------------- api create

  Future apiCreateOrder() async {
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

  void setInfomationPaymentMethodPaypalSuccess(String orderId) {
    OrderCurrentSingletone.instance().onlinePayment_orderId = orderId;
  }
}
