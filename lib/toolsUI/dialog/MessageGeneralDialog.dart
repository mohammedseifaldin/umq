import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/cupertino.dart';

typedef DialogMessageCallBack = Function(bool isClickOnYes);

class MessageGeneralDialog {
  static Future show(BuildContext context, String title, String msg,
      DialogMessageCallBack callBack) async {
    Log.i("CheckoutLoginDialog");
    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.bottomSlide,
      title: title,
      width: 350, //fix responsive of website
      desc: msg,
      btnCancelOnPress: () {
        //ToolsToast.i(context,  "click cancel");
        callBack(false);
      },
      btnOkOnPress: () {
        //ToolsToast.i(context,  "click login ");
        callBack(true);
      },
    ).show();
  }

  /// no button for "cancel"
  static Future scucces(BuildContext context, String title, String msg,
      DialogMessageCallBack callBack) async {
    Log.i("CheckoutLoginDialog");
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.bottomSlide,
      title: title,
      desc: msg,
      btnOkOnPress: () {
        //ToolsToast.i(context,  "click login ");
        callBack(true);
      },
    ).show();
  }

  static Future infoNoAction(BuildContext context, String title, String msg,
      DialogMessageCallBack callBack) async {
    Log.i("infoNoAction");
    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.bottomSlide,
      title: title,
      width: 350, //fix responsive of website
      desc: msg,

      btnOkOnPress: () {
        //ToolsToast.i(context,  "click login ");
        callBack(true);
      },
    ).show();
  }
}
