import 'dart:io';

import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:umq/modules/auth/provider/AuthChangeNotifier.dart';
import 'package:umq/modules/auth/provider/register_notifier.dart';
import 'package:umq/tools/resourceProject/ColorProject.dart';
import 'package:umq/tools/resourceProject/DrawableProject.dart';
import 'package:umq/toolsUI/Widgets/CircularImage.dart';
import 'package:umq/toolsUI/Widgets/button_primary_widget.dart';
import 'package:umq/toolsUI/Widgets/login_input_widget.dart';
import 'package:umq/toolsUI/textview/HeaderTextHelper.dart';
import 'package:umq/toolsUI/textview/SubTextHelper.dart';

class RegisterStudentPage extends StatefulWidget {
  String phone;
  @override
  RegisterStudentState createState() => RegisterStudentState();
  RegisterStudentPage(this.phone);
}

class RegisterStudentState extends StateMVC<RegisterStudentPage> {
  AuthChangeNotifier? provider;

  //---------------------------------------------------------------------- life cycle

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provider = AuthChangeNotifier.getListenFalse(context);
    provider!.firebaseTokenListener();
    provider!.phoneController.text = widget.phone;
  }

  @override
  Widget build(BuildContext context) {
    provider = AuthChangeNotifier.getListenTrue(context);

    return Scaffold(key: provider!.registerScaffoldKey, body: pageContent());
  }

  Widget pageContent() {
    return PageTemplate.t(this,
        title: "Register",
        statusBarColorCustom: HexColor(ColorProject.blueCerulean_3),
        assetBackground: DrawableProject.backgroundAuth,
        content: FormBody());
  }

  Widget ImageView() {
    return Stack(
      children: [
        imagePickerWidget(),
        Positioned(
          child: Visibility(
            child: CircularProgressIndicator(color: Colors.blue),
            visible: provider!.registerIsLoading,
          ),
          top: 1,
          bottom: 1,
          left: 1,
          right: 1,
        )
      ],
    );
  }

  Widget imagePickerWidget() {
    return GestureDetector(
      onTap: () => provider!.picImage(),
      child: CircularImage(
          150,
          provider!.registerImageXFile == null
              ? Icon(
                  Icons.account_circle,
                  size: 150,
                  color: Colors.grey.shade300,
                )
              : Image.file(File(provider!.registerImageXFile!.path))),
    );
  }

  Widget FormBody() {
    return Form(
      key: provider!.registerFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          ImageView(),
          const SizedBox(
            height: 20,
          ),
          HeaderTextHelper.HeaderText('New User', color: Colors.white),
          const SizedBox(
            height: 20,
          ),
          /** --- no need to edtit phone
              LoginInputWidget('Mobile Number', inputType: TextInputType.phone, controller: _con!.phone,enabled: false,),
           */

          LoginInputWidget(
            'user Name',
            inputType: TextInputType.text,
            controller: provider!.nameControlller,
          ),
          LoginInputWidget(
            'Email Address',
            inputType: TextInputType.emailAddress,
            controller: provider!.emailController,
          ),
          const SizedBox(
            height: 20,
          ),

          bt_register(),

          const SizedBox(
            height: 10,
          ),
          Center(
              child: Padding(
            child: SubTextHelper.SubText('OR', color: Colors.white),
            padding: EdgeInsets.symmetric(vertical: 10),
          )),

          //
          // ButtonSecoundryWidget('Login',onTap: (){
          //   GoTo.splashLogin(context);
          //
          // },),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }

  static final constantColor = HexColor(ColorProject.blueCerulean_1);

  BoxDecoration background() {
    return const BoxDecoration(
        // color:   constantColor, //statusbar color
        image: DecorationImage(
            image: AssetImage('assets/images/background_auth.jpeg'),
            fit: BoxFit.cover));
  }

  Widget bt_register() {
    return ButtonPrimaryWidget(
      'Register',
      onTap: () {
        provider!.updateDataSave();
      },
    );
  }
}
