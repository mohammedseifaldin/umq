import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/auth/data/response/ResponseLoginAdmin.dart';
import 'package:umq/modules/auth/data/source/LoginPhoneAPI.dart';
import 'package:umq/modules/auth/data/source/login_email_api.dart';
import 'package:umq/modules/auth/provider/AuthChangeNotifier.dart';
import 'package:umq/modules/auth/provider/get_user_data_notifier.dart';
import 'package:umq/modules/auth/provider/register_notifier.dart';
import 'package:umq/tools/cache/user_single_tone.dart';
import 'package:umq/tools/navigate/GoTo.dart';
import 'package:umq/tools/network/ToolsAPI.dart';
import 'package:umq/tools/values/ToolsValue.dart';
import 'package:umq/toolsUI/progress/lock_overlay/lock_overlay.dart';
import 'package:umq/toolsUI/toast/ToastTools.dart';

extension LoginNotifier on AuthChangeNotifier {
  //------------------------------------------------------------------- country code

  Future setTimeZoneToCountry() async {
    //wait for complete "initState" of page
    ToolsWait.waitToDo(300, () async {
      loginCountryCode = await ZoneTools.getZoneCountryDialCode("+966");
      notifyListeners();
    });
  }

  //-------------------------------------------------------------------  mobile verify

  Future loginAction(BuildContext context) async {
    if (!(loginFormKey.currentState!.validate())) {
      return;
    }
    loginFormKey.currentState!.save();
    FocusScope.of(context).unfocus();
    progressLoginUpdateStatus(true);
    await _startLogin(
      email: emailController.text,
      password: passwordController.text,
      context: context,
    );
    progressLoginUpdateStatus(false);
  }

  void progressLoginUpdateStatus(bool newUpdate) {
    loginProgress = newUpdate;
    notifyListeners();
  }

  // Future _startListenerToVerifyMobile(BuildContext context) async {
  //   String phone = emailController.value.text;
  //   loginPhone = ToolsPhone.fixEgyptAndSaudiNumber(loginCountryCode, phone);

  //   //wait
  //   GoTo.mobileVerifyGeneric(
  //     context,
  //     mobileToCheck: loginPhone,
  //     callback: (status, firebaseUId) {
  //       Log.i("mobileVerifyGeneric - status: $status ");

  //       //check failed
  //       if (status == false || ToolsValue.isEmpty(firebaseUId)) {
  //         LockOverlay().closeOverlay();
  //         //progress login
  //         progressLoginUpdateStatus(false);
  //         ToolsToast.i(context, "Failed To Login");
  //         return;
  //       }

  //       ///progress login start after verify otp done
  //       progressLoginUpdateStatus(true);

  //       //set
  //       loginUid = firebaseUId;

  //       //start api
  //       _loginOrCreateAccount(context);
  //     },
  //   );
  // }

  Future _loginOrCreateAccount(BuildContext context) async {
    Log.i("login - loginApiStart() - start");

    LoginPhoneAPI(
        loginCountryCode, emailController.value.text.toString(), loginUid!,
        (status, msg, response) {
      // progress_end();
      Log.i("login - loginApiStart() - status: $status");
      Log.i("login - loginApiStart() - msg: $msg");

      //check status
      if (status == false) {
        checkFailedUserNewNeedToRegister(context, msg, response);
        return;
      }

      //success login, make local validateion
      validateResponseChooseNewUserOrNotCompletedProfile(context, response);
    });
  }

  Future checkFailedUserNewNeedToRegister(
      BuildContext context, String msg, ResponseLoginAdmin response) async {
    //case "error_phone_not_found" :
    //              >> navigate to "register page" automaticaly
    /**
        flutter: ║
        flutter: ║    {
        flutter: ║         status: "error_phone_not_found",
        flutter: ║         code: 0,
        flutter: ║         new_account: 1,
        flutter: ║         message: "This Phone Number not have account"
        flutter: ║    }
     */
    if (response.status == "error_phone_not_found") {
      LockOverlay().closeOverlay();
      registerMobile(context);
      return;
    } else {
      //show toast
      ToolsToast.i(context, msg);

      //hide progress
      LockOverlay().closeOverlay();
      progressLoginUpdateStatus(false);
    }
  }
  //-------------------------------------------------------------------------- choose case

  Future validateResponseChooseNewUserOrNotCompletedProfile(
      BuildContext context, ResponseLoginAdmin value) async {
    Log.i("login - validateResponse() - start");

    //case no data downloaded
    // if (value == null) {
    //   LockOverlay().closeOverlay();
    //   progressLoginUpdateStatus(false);
    //   ToolsToast.i(context, "No Internet Connection, Try Again");
    //   return;
    // }

    //case "New User" while enter his phone as login
    if (ToolsAPI.isSuccess(value.newAccount)) {
      registerMobile(context);
      return;
    }

    //case failed any reasone
    if (ToolsAPI.isFailed(value.code)) {
      ToolsToast.i(context, value.message!);
      LockOverlay().closeOverlay();
      progressLoginUpdateStatus(false);
      return;
    }

    //check blocked
    bool isBlocked = ToolsAPI.parseBoolean_int(value.data!.user!.block);
    if (isBlocked) {
      LockOverlay().closeOverlay();
      progressLoginUpdateStatus(false);
      ToolsToast.i(context, "User Blocked By Admin");
      return;
    }

    //check hidden
    bool isHidden = ToolsAPI.parseBoolean_int(value.data!.user!.hidden);
    if (isHidden) {
      LockOverlay().closeOverlay();
      progressLoginUpdateStatus(false);
      ToolsToast.i(context, "User Deleted By Admin");
      return;
    }

    //case not enter name until now
    /**
        means this user not complete the process of register
     */
    String userName = UserSingleTone.instance().getUserName();
    if (ToolsValue.isEmpty(userName)) {
      LockOverlay().closeOverlay();
      progressLoginUpdateStatus(false);
      /**
          make user to enter his username
       */
      String phone = emailController.value.text.toString();
      GoTo.registerStudent(context, loginCountryCode, phone);
      return;
    }

    //home  page
    LockOverlay().closeOverlay();
    GoTo.chooseHomeByTypeRoleUser(context);
  }

  Future _startLogin({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    return await LoginEmailAPI(
      email: email,
      pass: password,
      callBack: (status, msg, response) {
        ToolsToast.i(context, msg);
        if (status) {
          UserSingleTone.instance().setToken(response["access_token"]);
          startGettingUserData(
            context: context,
            token: response["access_token"],
          );
          GoTo.chooseHomeByTypeRoleUser(context);
        }
      },
    ).call();
  }
}
