import 'dart:io';

import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../provider/AuthChangeNotifier.dart';
import '../../../provider/register_notifier.dart';
import '../../../../../tools/resourceProject/ColorProject.dart';
import '../../../../../tools/resourceProject/DrawableProject.dart';
import '../../../../../toolsUI/Widgets/CircularImage.dart';
import '../../../../../toolsUI/Widgets/button_primary_widget.dart';
import '../../../../../toolsUI/Widgets/login_input_widget.dart';
import '../../../../../toolsUI/textview/HeaderTextHelper.dart';
import '../../../../../toolsUI/textview/SubTextHelper.dart';

class RegisterStudentPage extends StatefulWidget {
  final String phone;
  @override
  RegisterStudentState createState() => RegisterStudentState();
  RegisterStudentPage(this.phone, {super.key});
}

class RegisterStudentState extends StateMVC<RegisterStudentPage> {
  AuthChangeNotifier? provider;

  //---------------------------------------------------------------------- life cycle

  @override
  void initState() {
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
          top: 1,
          bottom: 1,
          left: 1,
          right: 1,
          child: Visibility(
            visible: provider!.registerIsLoading,
            child: const CircularProgressIndicator(color: Colors.blue),
          ),
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
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: SubTextHelper.SubText('OR', color: Colors.white),
          )),

          //
          // ButtonSecoundryWidget('Login',onTap: (){
          //   GoTo.splashLogin(context);
          //
          // },),
          const SizedBox(
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
