import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:umq/tools/navigate/GoTo.dart';

class CheckoutLoginDialog {
  static Future show(BuildContext context) async {
    Log.i("CheckoutLoginDialog");
    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.bottomSlide,
      width: 300, //fix responsive of website
      title: 'Checkout Login',
      desc: 'To take all feature of application you need to login first',
      btnCancelOnPress: () {
        //ToolsToast.i(context,  "click cancel");
      },
      btnOkOnPress: () {
        //ToolsToast.i(context,  "click login ");
        GoTo.splashLogin(context);
      },
    ).show();
  }
}
