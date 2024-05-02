import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:umq/modules/auth/data/response/ResponseRegisterStudent.dart';
import 'package:umq/modules/auth/data/source/RegisterStudentAPI.dart';
import 'package:umq/modules/auth/data/source/UpdateUserDataAPI.dart';
import 'package:umq/modules/auth/data/source/register_email_api.dart';
import 'package:umq/modules/auth/provider/AuthChangeNotifier.dart';
import 'package:umq/modules/auth/provider/get_user_data_notifier.dart';
import 'package:umq/modules/auth/provider/login_notifier.dart';
import 'package:umq/tools/cache/session_repo.dart';
import 'package:umq/tools/cache/user_single_tone.dart';
import 'package:umq/tools/laravel/upload/UploadFileLaravelAPI.dart';
import 'package:umq/tools/navigate/GoTo.dart';
import 'package:umq/tools/network/BackendConstant.dart';
import 'package:umq/tools/network/ToolsAPI.dart';
import 'package:umq/toolsUI/progress/lock_overlay/lock_overlay.dart';
import 'package:umq/toolsUI/toast/ToastTools.dart';

extension RegisterNotifier on AuthChangeNotifier {
  //--------------------------------------------------------------------- create account

  Future createAccountAction(BuildContext context) async {
    loginFormKey.currentState!.save();
    GoTo.registerStudentWithEmail(context: context);
  }

  void startMobileVerify(BuildContext context) async {
    //start
    // loginFullPhone =  PhoneEgyption.getFullPhone( loginCountryCode, loginPhoneController.value.text);
    // loginPhone = ToolsPhone.fixEgyptAndSaudiNumber(
    //     loginCountryCode, emailController.value.text);

    // GoTo.mobileVerifyGeneric(context, mobileToCheck: loginPhone,
    //     callback: (status, firebaseUId) {
    //   //check failed
    //   if (status == false || ToolsValue.isEmpty(firebaseUId)) {
    //     LockOverlay().closeOverlay();
    //     ToolsToast.i(context, "Failed To Register");
    //     return;
    //   }

    //   Log.i(
    //       "mobileVerifyCreateAccount() - mobileVerifyGeneric - phoneController.value.text: ${emailController.value.text}");
    //   Log.i(
    //       "mobileVerifyCreateAccount() - mobileVerifyGeneric - fullPhone: $loginPhone");

    //   //set
    //   loginUid = firebaseUId;

    //   //start api
    //   registerMobile(context);
    // });
  }

  /// ------ Cases call this method:
  /// 1- case user click on button "Register New Account"
  /// 2- case user enter phone number not found in DB, means he his new user,
  /// by click wrong button "login" instead of "register" button.

  void registerMobile(BuildContext context) async {
    progressLoginUpdateStatus(true);

    //hide keybaord
    FocusScope.of(context).unfocus();

    //show progress
    LockOverlay().showClassicLoadingOverlay(context);

    FirebaseMessaging.instance.getToken().then((value) {
      loginTokenMessage = value!;
      _startAPIRegister(context);
    });
  }

  Future _startAPIRegister(BuildContext context) async {
    //api
    String phone = emailController.value.text;
    String country = loginCountryCode;
    String pass = loginUid!;
    Log.i("startAPIRegister() - country: $country");
    Log.i("startAPIRegister() - phone: $phone");
    // Log.i( "startAPIRegister() - tokenMessage: " + tokenMessage);
    RegisterStudentAPI(country, loginPhone, pass, loginTokenMessage,
        (status, message, response) {
      progressLoginUpdateStatus(false);

      if (status == false) {
        LockOverlay().closeOverlay();
        ToolsToast.i(context, message);
        return;
      }

      //case no data downloaded
      // if (response == null) {
      //   LockOverlay().closeOverlay();
      //   ToolsToast.i(context, "No Internet Connection, Try Again");
      //   return;
      // }

      //case user phone already register
      Log.i(
          "startAPIRegister()  - response.userAlreadyFound! ${response.userAlreadyFound}");
      if (response.userAlreadyFound!) {
        LockOverlay().closeOverlay();
        caseUserAlreadyFound(context, response);
        return;
      }

      //case success
      if (ToolsAPI.isSuccess(response.code)) {
        successRegister(context, response);
        // Navigator.pushNamed(scaffoldKey.currentContext!, '/register',arguments: countryCode+phoneController.value.text);
        return;
      }

      //nothing happend
      ToolsToast.i(context, "Try Again");
      LockOverlay().closeOverlay();
    });
  }

  //--------------------------------------------------------------- parse response cases happened

  Future successRegister(
      BuildContext context, ResponseRegisterStudent response) async {
    UserSingleTone.instance().saveUserLogin(response.data!, response.token!,
        () {
      //progress end wait for save cache user login
      LockOverlay().closeOverlay();

      //next
      GoTo.registerStudent(
          context, loginCountryCode, emailController.value.text);
    });
  }

  Future caseUserAlreadyFound(
      BuildContext context, ResponseRegisterStudent response) async {
    /**
        {
        "status": "failed",
        "code": 0,
        "user_already_found": true,
        "message": "Users already found"
        }
     */
    // Log.i( "caseUserAlreadyFound() - message  " + response.message!  );
    // Log.i( "caseUserAlreadyFound() - scaffoldKey.currentContext  " + context.toString() );
    // Log.i( "caseUserAlreadyFound() - context  " + context.toString() );
    ToolsToast.i(context, response.message!);
  }

  //---------------------------------------------------------------------- firebase

  firebaseTokenListener() {
    FirebaseMessaging.instance.getToken().then((value) {
      registerToken = value;
    });
  }

//---------------------------------------------------------------------- picker photo

  void picImage() async {
    await registerImagePicker
        .pickImage(source: ImageSource.camera)
        .then((value) {
      if (value != null) {
        registerImageXFile = value;
        UploadImage();
      }
    });
  }

  void UploadImage() {
    //progress
    registerIsLoading = true;
    notifyListeners();

    //api
    apiUploadProfileRequest();
  }

  Future apiUploadProfileRequest() async {
    //listener
    String urlApiLink = BackendConstant.getUploadFileUrl();
    await UploadFileLaravelAPI().getDataByXFile(
        urlAPILink: urlApiLink,
        xFile: registerImageXFile!,
        callBack: (status, msg, responseLaravelUpload) {
          //check failed
          if (status == false) {
            //progress
            registerIsLoading = false;
            notifyListeners();

            ToolsToast.i(registerScaffoldKey.currentContext!, msg);
            return;
          }

          //success
          String uploadedUrl = responseLaravelUpload.data!.path!;
          registerPhoto = uploadedUrl;

          //progress
          registerIsLoading = false;
          notifyListeners();
        });
  }

  //------------------------------------------------------------------------------- update data profile

  void updateDataSave() async {
    FocusScope.of(registerScaffoldKey.currentContext!).unfocus();
    if (registerFormKey.currentState!.validate()) {
      registerFormKey.currentState!.save();
      LockOverlay()
          .showClassicLoadingOverlay(registerScaffoldKey.currentContext);

      startAPIUpdate();
    }
  }

  void registerAction(BuildContext context) async {
    if (!(registerFormKey.currentState!.validate())) {
      return;
    }
    registerFormKey.currentState!.save();
    FocusScope.of(context).unfocus();
    LockOverlay().showClassicLoadingOverlay(registerScaffoldKey.currentContext);
    await _startRegister(
      context: context,
      email: emailController.text,
      password: passwordController.text,
      name: nameControlller.text,
      country: loginCountryCode,
      mobile: loginPhone,
    );
    LockOverlay().closeOverlay();
  }

  Future _startRegister({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
    required String mobile,
    required String country,
  }) async {
    await RegisterEmailAPI(
      email: email,
      pass: password,
      country: country,
      mobile: mobile,
      name: name,
      callBack: (status, msg, response) async {
        ToolsToast.i(context, msg);
        if (status) {
          GoTo.chooseHomeByTypeRoleUser(context);
          startGettingUserData(
            context: context,
            token: response["access_token"],
          );
          await UserSingleTone.instance().setToken(response["access_token"]);
        }
      },
    ).call();
  }

  Future startAPIUpdate() async {
    String userID = await getUserID();
    String name = nameControlller.value.text.toString();
    String emailValue = emailController.value.text.toString();
    UpdateUserDataAPI(userID, name, emailValue, registerPhoto,
        (status, msg, response) {
      LockOverlay().closeOverlay();

      if (status == false) {
        ToolsToast.i(registerScaffoldKey.currentContext!, msg);
        return;
      }

      if (ToolsAPI.isFailed(response.code)) {
        ToolsToast.i(registerScaffoldKey.currentContext!, msg);
        return;
      }

      //success
      GoTo.registerChooseTypeUser(registerScaffoldKey.currentContext!);
    });
  }
}
