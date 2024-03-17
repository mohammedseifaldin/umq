import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:umq/modules/auth/provider/AuthChangeNotifier.dart';
import 'package:umq/modules/auth/provider/mobile_otp/ConfirmPinController.dart';
import 'package:umq/modules/auth/provider/mobile_otp/SendOTPController.dart';
import 'package:umq/tools/resourceProject/ColorProject.dart';
import 'package:umq/tools/resourceProject/FontProject.dart';
import 'package:umq/toolsUI/Widgets/button_primary_widget.dart';
import 'package:umq/toolsUI/background/ScubaBackgroundImage.dart';
import 'package:umq/toolsUI/toolbar/transparentToolbar/ToolbarTransparent.dart';

import '../../../provider/mobile_otp/mobile_verification_controller.dart';
 

typedef SignToOtpFirebaseCallBack = Function( bool status, String useridFirebaseAuth );

class SignWithMobilePage extends StatefulWidget {

  SignToOtpFirebaseCallBack callback;
  String mobileToCheck = "";

  SignWithMobilePage( this.callback, {super.key, 
    required String mobile
  }) {
    mobileToCheck = mobile  ;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PageStateFirebaseAuthMobile(  );
  }
}

class PageStateFirebaseAuthMobile extends StateMVC<SignWithMobilePage> {

  //------------------------------------------------------------------------ variable


  AuthChangeNotifier? provider;


  //------------------------------------------------------------------------ life cycle

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provider = AuthChangeNotifier.getListenFalse(context);
    setDefaultValuesOnCreatePage();
    provider!.setTokenMessage();
  }

  void setDefaultValuesOnCreatePage(){
    provider!.mobileToCheck = widget.mobileToCheck;
    provider!.callback = widget.callback;
  }

  //------------------------------------------------------------------------ build

  @override
  Widget build(BuildContext context) {
    provider = AuthChangeNotifier.getListenTrue(context);
    setDefaultValuesOnCreatePage();

    return Scaffold(
      key: provider!.scaffoldKey,
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: pageContent(),
          ),
        ),
      ));
  }

  Widget pageContent(){
    return Stack(
      children: [
        ScubaBackgroundImage.getImageResponsive( context),
        containerAllContent(),
      ],
    );
  }


  //---------------------------------------------------------------------  content

  Widget containerAllContent(){
   // Log.i( "containerAllContent() - _con!.isSendedOTP: " + _con!.isSendedOTP.toString() );
    return   Container(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [

          ToolbarTransparent( context, "Welcome", HexColor(ColorProject.white_sun_4)),

         mobileViewWhenFirstTimeOpenPage(),
          otpTextFieldView(),
          SizedBox(height: 50,),
          buttonNext()

        ],
      ),

    );

  }

  //------------------------------------------------------------------------- otp
 

  Widget otpTextFieldView(){
   // check to change status to refresh
    if( provider!.isSendedOTP == false  ) {
     return EmptyView.zero();
    }

    // check to change status to refresh
    if( provider!.isRetryToSendOTP ) {
      return EmptyView.zero();
    }

    //view s
    var otp =  OTPTextFieldFastor(
      countNumber: 6,
      decoration: BoarderHelper.box(
          colorLine: HexColor(ColorProject.blue_fish_back),
          colorBackground: HexColor(ColorProject.blue_fish_back)
      ),
      fontFamily: FontProject.beach,
      fontSize: 13,
      colorText: Colors.white,
      onComplete: ( isComplete ){
        Log.i("otpFields() - isComplete: $isComplete");
        provider!.confirmPinNumberClick(context);
      },
      onChangeCode: (codeUpdate ) {
        Log.i("otpFields() - onChangeCode: $codeUpdate");
        provider!.PIN = codeUpdate;
      },
    );

    // var otp =    OTPTextFieldFastor(
    //   changePin: (String pin){
    //   provider!.PIN = pin;
    // }, complete: (bool value) {
    //   provider!.ConfirmPinNumberClick();
    // }, state: (OTPState value) {
    //   otpState = value;
    // }, countNumber: null,);

    return Container(
      margin: EdgeInsets.only(top: 50),
      child: otp,
    );
  }


  //------------------------------------------------------------------------- button next

  Widget buttonNext(){
   // Log.i( "buttonNext() - _con!.isSendedOTP: " + _con!.isSendedOTP.toString()  );

    var bt =    ButtonPrimaryWidget( getButtonName(),onTap: (){

      //case retry send opt
      if( provider!.isRetryToSendOTP ) {
        provider!.retrySendOTP();
        return;
      }

      //case already send otp
      if(provider!.isSendedOTP){
        provider!.confirmPinNumberClick(context);
      }

      //case not send otp before, it's first time to send otp
      provider!.sendOTPClick();
    },);

    //responsive web
    if( DeviceTools.isPlatformWeb() ) {
      return SizedBox( child: bt, width: 200 );
    }

    return bt;
  }



  String getButtonName(){
    //case retry send opt
    if( provider!.isRetryToSendOTP ) {
      return 'Retry Send OTP';
    }
    if( provider!.isSendedOTP ) {
      return 'Verify OTP';
    } else if( provider!.isFirstTimeOpenPage() ){
      return 'Confirm';
    } else {
      return 'SEND';
    }
  }

  //---------------------------------------------------------------- mobile view



  Widget mobileViewWhenFirstTimeOpenPage() {
    if( provider!.isFirstTimeOpenPage() ) {
      return _showMobileToConfirmSendOtp();
    } else {
      return SizedBox();
    }
  }


  Widget _showMobileToConfirmSendOtp(){
    String msg = "Confirm This Mobile Number\n";
    msg += widget.mobileToCheck;
    var txt =  TextFastor(  msg ,
        fontSize: 20,
        color: HexColor(ColorProject.white_oxygen),
    );

    //responsive web
    if( DeviceTools.isPlatformWeb() ) {
      return Container(
        alignment: Alignment.center,
        child: txt,
      );
    } else {
      return Container(
        margin: EdgeInsets.symmetric(horizontal:10 ),
        alignment: Alignment.topLeft,
        child: txt,
      );
    }



  }



}
