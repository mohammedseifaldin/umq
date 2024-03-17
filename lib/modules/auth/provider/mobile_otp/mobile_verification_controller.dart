import 'dart:async';

import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/auth/provider/AuthChangeNotifier.dart';
import 'package:umq/toolsUI/progress/lock_overlay/lock_overlay.dart';
import 'package:umq/toolsUI/toast/ToastTools.dart';

extension MobileVerificationController on AuthChangeNotifier {
  //---------------------------------------------------------------------- private init constructor

  void setTokenMessage() {
    FirebaseMessaging.instance.getToken().then((value) {
      token = value;
    });
  }

  //--------------------------------------------------------------- show meesage

  void showErrorMessage(BuildContext context, String msg) {
    Log.i("showErrorMessage() - msg: " + msg);
    failed(context, msg);
  }

  //----------------------------------------------------------------- what to after

  Future failed(BuildContext context, String msg) async {
    ToolsToast.i(context, msg);

    //progress
    LockOverlay().closeOverlay();

    isRetryToSendOTP = true;
    notifyListeners();
  }

  Future whatToDoAfterSuccess(String uid) async {
    //finish page
    Navigator.pop(scaffoldKey.currentContext!);

    //wait to finish chrome reCAPTCHA
    Timer(Duration(milliseconds: 1000), () {
      //300 sometimes make crash
      // Log.i("whatToDoAfterSuccess() - end" );

      //call back
      callback!(true, uid);
    });
  }
}
