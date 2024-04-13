import 'package:umq/modules/auth/provider/auth_change_notifier.dart';

extension SendOTPController on AuthChangeNotifier {
  //---------------------------------------------------------------------- send otp

  // void retrySendOTP() {
  //   //remove init again
  //   isRetryToSendOTP = false;
  //   notifyListeners();

  //   //
  //   sendOTPClick();
  // }

  //---------------------------------------------------------------------- send otp

  // // void sendOTPClick() async {
  // //   /** --- to rapid return userIdFirebase
  // //       if( EnvironmentConstant.isTest ) {
  // //       whatToDoAfterSuccess( "12345678");
  // //       return;
  // //       }
  // //    */

  // //   FocusScope.of(scaffoldKey.currentContext!).unfocus();

  // //   //progress
  // //   LockOverlay().showClassicLoadingOverlay(scaffoldKey.currentContext);
  // //   FirebaseAuth _auth = FirebaseAuth.instance;

  // //   await _auth.signOut();

  // //   await _sendOTPFunctionChoosePlatform(mobileToCheck);
  // // }

  // // Future _sendOTPFunctionChoosePlatform(String fullPhone) async {
  //   if (DeviceTools.isPlatformWeb()) {
  //     await webSendOTP(fullPhone);
  //   } else {
  //     await _mobileSendOTP(fullPhone);
  //   }
  // }

  //----------------------------------------------------------------------- mobile platform

  // Future _mobileSendOTP(String fullPhone) async {
  //   Log.i("_mobileSendOTP() - fullPhone: " + fullPhone);
  //   FirebaseAuth _auth = FirebaseAuth.instance;
  //   await _auth.verifyPhoneNumber(
  //       phoneNumber: fullPhone,
  //       timeout: Duration(seconds: 10),
  //       verificationCompleted: (PhoneAuthCredential auth) {
  //         print(auth);
  //         LockOverlay().closeOverlay();
  //       },
  //       verificationFailed: (FirebaseAuthException mException) {
  //         LockOverlay().closeOverlay();

  //         var sMessage =
  //             ScaffoldMessenger.of(scaffoldKey.currentState!.context);

  //         sMessage.showSnackBar(SnackBar(
  //           content: Text("${mException.message}"),
  //         ));
  //       },
  //       codeAutoRetrievalTimeout: (verificationId) {
  //         LockOverlay().closeOverlay();
  //       },
  //       codeSent: (String verificationId, int? forceResendingToken) {
  //         Log.i("_mobileSendOTP() - codeSent success");
  //         LockOverlay().closeOverlay();
  //         VERIFICATIONID = verificationId;
  //         isSendedOTP = true;
  //         notifyListeners();
  //       });
  // }

//----------------------------------------------------------------------- web  platform

  // Future webSendOTP(String fullPhone) async {
  //   // Log.i( "webSendOTP() - fullPhone: " + fullPhone );

  //   ConfirmationResult confirmationResult =
  //       await webFirebaseController.sendOTP(fullPhone);

  //   LockOverlay().closeOverlay();

  //   if (confirmationResult != null) {
  //     isSendedOTP = true;
  //     notifyListeners();
  //   }
  // }
}
