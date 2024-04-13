import 'package:umq/modules/auth/provider/auth_change_notifier.dart';

extension ConfirmPinController on AuthChangeNotifier {
  bool isFirstTimeOpenPage() {
    if (isRetryToSendOTP) {
      return false;
    } else if (isSendedOTP) {
      return false;
    }
    return true;
  }
//---------------------------------------------------------------------- verfiy otp

  // void confirmPinNumberClick(BuildContext context) async {
  //   //keyboard
  //   FocusScope.of(context).unfocus();

  //   //choose platform
  //   if (DeviceTools.isPlatformWeb()) {
  //     await verifyOTP_web(context);
  //   } else {
  //     await _verifyOTP_mobile(context);
  //   }
  // }

  //---------------------------------------------------------------------- mobile platform

  // Future _verifyOTP_mobile(
  //   BuildContext context,
  // ) async {
  //   //credential object
  //   FirebaseAuth _auth = FirebaseAuth.instance;
  //   var _authCredential = PhoneAuthProvider.credential(
  //       verificationId: VERIFICATIONID, smsCode: PIN);

  //   //check if null means failed
  //   if (_authCredential == null) {
  //     showErrorMessage(
  //         context,
  //         "_verifyOTP_mobile() - _authCredential is (null) object, VERIFICATIONID: " +
  //             VERIFICATIONID);
  //     return;
  //   }

  //   //progresss
  //   LockOverlay().showClassicLoadingOverlay(scaffoldKey.currentContext);

  //   //sign the credential
  //   await _auth.signInWithCredential(_authCredential).catchError((error) {
  //     //progress
  //     LockOverlay().closeOverlay();

  //     if (error is FirebaseAuthException) {
  //       Log.i("_verifyOTP_mobile() - catchError() error: " + error.toString());
  //       Log.i("_verifyOTP_mobile() - catchError() error.code: " + error.code);

  //       if (error.code == "invalid-verification-code") {
  //         showErrorMessage(context, "Invalid OTP");
  //       } else {
  //         showErrorMessage(context, "${error.message}");
  //       }
  //     } else {
  //       showErrorMessage(context, "${error.messageRemote}");
  //     }
  //   }).then((value) async {
  //     //check the confirmation enter right
  //     /**
  //      case real phone number, and user enter wrong PIN code,
  //      it's pring here
  //      */
  //     try {
  //       if (value.user == null || ToolsValue.isEmpty(value.user!.uid)) {
  //         showErrorMessage(context, "Wrong Code entered");
  //         return;
  //       }
  //     } catch (e) {
  //       Log.i("general - e: " + e.toString());
  //       showErrorMessage(context, "Wrong Code entered");
  //       return;
  //     }

  //     Log.i("_verifyOTP_mobile() - success ");
  //     whatToDoAfterSuccess(value.user!.uid);
  //   });
  // }

  // //---------------------------------------------------------------------- web platform

  // Future verifyOTP_web(
  //   BuildContext context,
  // ) async {
  //   // Log.i( "_verifyOTP_web() - start  " );
  //   await webFirebaseController.verifyMyOtpCode(PIN, (isSuccess) {
  //     if (isSuccess == false) {
  //       failed(context, "Failed to authentication");
  //       return;
  //     }

  //     // successConfirmOTPByWeb();
  //   });
  // }

  // Future successConfirmOTPByWeb() async {
  //   FirebaseAuth _auth = FirebaseAuth.instance;
  //   String uid = _auth.currentUser!.uid.toString();

  //   if (EnvironmentConstant.isTest) {
  //     Log.i("successConfirmOTPByWeb() - uid: " + uid);
  //   }

  //   whatToDoAfterSuccess(uid);
  // }
}
