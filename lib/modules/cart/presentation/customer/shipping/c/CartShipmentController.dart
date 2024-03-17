import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/modules/cart/presentation/customer/shipping/v/CartShipmentPage.dart';
import 'package:umq/tools/keyboard/ToolsKeyboard.dart';
import 'package:umq/tools/navigate/GoTo.dart';
import 'package:umq/toolsUI/toast/ToastTools.dart';

extension CartShipmentController on CartShipmentState {
  //--------------------------------------------------------------------- button next

  Future clickNext() async {
    //keyboard
    ToolsKeyboard.dismiss(context);

    //validate
    if (_validate() == false) return;

    //save data
    // OrderCurrentSingletone.instance().city = citySelectedObject;
    // OrderCurrentSingletone.instance().address = address_txt;

    //next
    GoTo.cartPaymentMethod(context);
  }

  bool _validate() {
    var result = true; //default good

    //address
    if (ToolsValidation.isMoreThan2(address_txt) == false) {
      ToolsToast.i(context, "Enter your Address");
      return false;
    }

    //city
    if (citySelectedObject == null) {
      ToolsToast.i(context, "Select City");
      return false;
    }

    return result;
  }
}
