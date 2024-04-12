import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/modules/cart/presentation/customer/payment_method/v/CartPaymentMethodPage.dart';
import 'package:umq/modules/cart/shared/OrderCurrentSingletone.dart';
import 'package:umq/tools/constant/EPaymentMethod.dart';
import 'package:umq/tools/navigate/GoTo.dart';
import 'package:umq/toolsUI/toast/ToastTools.dart';

extension CartPaymentMethodController on CartPaymentMethodState {
  Future setEditPaymentMethod() async {
    var current = OrderCurrentSingletone.instance().paymentMethod;
    if (ToolsValidation.isEmpty(current)) {
      return;
    }

    groupValue_method = current;
    Log.i("setEditPaymentMethod() - current: $current");
    //set
    handlerRadio_paymentMethod(current);
  }

  Future clickNext() async {
    //check empty
    if (ToolsValidation.isEmpty(groupValue_method)) {
      ToolsToast.i(context, "Choose Payment method");
      return;
    }
    Log.i("clickNext() - groupValue_method: $groupValue_method");

    // cash
    if (groupValue_method == EPaymentMethod.cash.name) {
      _typeCash();
      return;
    }

    //online
    if (groupValue_method == EPaymentMethod.online.name) {
      _typeOnline();
      return;
    }
  }

  Future _typeCash() async {
    // next
    GoTo.cartReceiptPage(context);
  }

  Future _typeOnline() async {
    GoTo.cartReceiptPage(context);
  }

  void handlerRadio_paymentMethod(String value) {
    Log.i("handlerRadio_paymentMethod() - value: $value");

    //set current
    OrderCurrentSingletone.instance().paymentMethod = value;

    setState(() {
      groupValue_method = value;
    });
  }
}
