import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:umq/modules/place/data/model/MCity.dart';
import 'package:umq/modules/profile/data/model/MOrganization.dart';
import 'package:umq/modules/auth/presentation/customer/MobileVerification/SignWithMobilePage.dart';
import 'package:umq/modules/auth/provider/mobile_otp/FirebaseWebAuthenticationController.dart';

class AuthChangeNotifier extends ChangeNotifier {
  //------------------------------------------------------------------------ variable

  //+++++++++++++++++++++++++ login page

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final nameControlller = TextEditingController();
  String loginCountryCode = ''; //example +20
  String loginPhone = "";
  String? loginUid;
  String loginTokenMessage = "";

  bool loginProgress = false;

  //+++++++++++++++++++++++++ register page

  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> registerScaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> registerScaffoldKeyState =
      GlobalKey<ScaffoldState>();
  

  String registerSelectedGender = 'City';
  String? registerPhoto;
  String? registerToken;
  bool registerIsLoading = false;
  XFile? registerImageXFile;
  ImagePicker registerImagePicker = ImagePicker();

  //++++++++++++++++++++++++++++++++++ become teacher page

  GlobalKey<ScaffoldState> becomeTeacherScaffoldKey =
      GlobalKey<ScaffoldState>();
  List<MCity> becomeTeacherCities = [
    MCity.constructor(0, "Select City", "Select City")
  ];
  List<MOrganization> becomeTeacherOrganization = [
    MOrganization(0, "Select Organization")
  ];
  MCity? becomeTeacherSelectedCity;
  MOrganization? becomeTeacherSelectedOrganization;

  //++++++++++++++++++++++++++++++++++ otp page

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  // TextEditingController phoneController=TextEditingController();
  // String countryCode=''; //+20
  String VERIFICATIONID = '';
  String PIN = ""; //pin 6 number user enter by himself
  bool isSendedOTP = false; //true: cause the ui of "OTP" textfield to be show
  bool isRetryToSendOTP = false; // true: casue the ui will resend otp"

  String mobileToCheck = "";

  String? token;

  var webFirebaseController = FirebaseWebAuthenticationController();
  SignToOtpFirebaseCallBack? callback;

  //------------------------------------------------------------------------ instance

  static AuthChangeNotifier getListenFalse(BuildContext context) {
    return Provider.of<AuthChangeNotifier>(context, listen: false);
  }

  static AuthChangeNotifier getListenTrue(BuildContext context) {
    return Provider.of<AuthChangeNotifier>(context, listen: true);
  }
}
