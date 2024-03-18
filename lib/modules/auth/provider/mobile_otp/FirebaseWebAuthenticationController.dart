



typedef WebAuthCallBackConfirmOTP = Function(bool isSuccess);

class FirebaseWebAuthenticationController {


  String phoneNumber = "";
  // ConfirmationResult? confirmationResult;

  // Future sendOTP(String phoneNumber) async {
  //   // Log.i("sendOTP() - phoneNumber: $phoneNumber");
  //   this.phoneNumber = phoneNumber;
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   confirmationResult = await auth.signInWithPhoneNumber(
  //     '$phoneNumber',
  //   );
  //  // Log.i("sendOTP() - confirmationResult: $confirmationResult");
  //   return confirmationResult;
  // }

  // Future<bool> verifyMyOtpCode(String otp, WebAuthCallBackConfirmOTP callback) async {
  //   if(confirmationResult == null ) {
  //     Log.i( "verifyMyOtpCode() - confirmationResult == null - stop  "  );
  //     callback(false);
  //     return false;
  //   }
  //   UserCredential userCredential = await confirmationResult!.confirm(otp);
  //  Log.i( "verifyMyOtpCode() - userCredential  "  + userCredential.toString() );

  //   //check success login
  //   FirebaseAuth _auth = FirebaseAuth.instance;
  //   if( _auth == null  ||
  //       _auth.currentUser == null ||
  //     _auth.currentUser!.uid == null
  //   ) {
  //     callback(false);
  //     return false ;
  //   }
  //  // Log.i("verifyMyOtpCode() - _auth.currentUser!.uid: " + _auth.currentUser!.uid.toString() );

  //   //bool isNewUserLoginNow = userCredential.additionalUserInfo
  //   //Log.i("verifyMyOtpCode() - isNewUserLoginNow: $isNewUserLoginNow");

  //   //finish
  //   callback(true);
  //   return true;
  // }


}
/**

    FirebaseAuth _auth = FirebaseAuth.instance;
    await _auth.signInWithPhoneNumber(
    fullPhone,
    RecaptchaVerifier(
    container: 'recaptcha',
    size: RecaptchaVerifierSize.compact,
    theme: RecaptchaVerifierTheme.dark,
    onSuccess: (){
    LockOverlay().closeOverlay();
    Log.i( "_webSendOTP - onSuccess "  );
    successLoginByWeb = true;
    notifyListeners();

    },
    onError: (FirebaseAuthException exception){
    LockOverlay().closeOverlay();
    Log.i( "_webSendOTP - exception: " + exception.toString() );
    ToolsToast.i( scaffoldKey.currentContext!,  exception.message.toString() );
    successLoginByWeb = false;
    notifyListeners();
    }, onExpired: (){
    LockOverlay().closeOverlay();
    Log.i( "_webSendOTP - onExpired "  );
    notifyListeners();
    }
    ));
 */