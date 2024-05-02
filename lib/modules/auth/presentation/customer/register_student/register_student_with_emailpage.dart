import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:umq/modules/auth/presentation/customer/register_student/mobile_input_view.dart';
import 'package:umq/modules/auth/provider/AuthChangeNotifier.dart';
import 'package:umq/modules/auth/provider/register_notifier.dart';
import 'package:umq/tools/navigate/GoTo.dart';
import 'package:umq/tools/resourceProject/ColorProject.dart';
import 'package:umq/tools/resourceProject/DrawableProject.dart';
import 'package:umq/toolsUI/Widgets/button_primary_widget.dart';
import 'package:umq/toolsUI/Widgets/button_secoundry_widget.dart';
import 'package:umq/toolsUI/Widgets/login_input_widget.dart';
import 'package:umq/toolsUI/textview/HeaderTextHelper.dart';
import 'package:umq/toolsUI/textview/SubTextHelper.dart';

class RegisterStudentWithEmailPage extends StatefulWidget {
  const RegisterStudentWithEmailPage({super.key});
  @override
  RegisterStudentState createState() => RegisterStudentState();
}

class RegisterStudentState extends StateMVC<RegisterStudentWithEmailPage> {
  late AuthChangeNotifier provider;

  @override
  void initState() {
    provider = AuthChangeNotifier.getListenFalse(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    provider = AuthChangeNotifier.getListenTrue(context);
    return Scaffold(
      key: provider.registerScaffoldKey,
      body: PageTemplate.t(
        this,
        title: "Register",
        statusBarColorCustom: HexColor(ColorProject.blueCerulean_3),
        assetBackground: DrawableProject.backgroundAuth,
        content: Form(
          key: provider.registerFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              HeaderTextHelper.HeaderText('New User', color: Colors.white),
              const SizedBox(height: 20),
              LoginInputWidget(
                'User Name',
                inputType: TextInputType.text,
                prefixIcon: const Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                controller: provider.nameControlller,
              ),
              LoginInputWidget(
                'Email Address',
                prefixIcon: const Icon(
                  Icons.email_rounded,
                  color: Colors.white,
                ),
                inputType: TextInputType.emailAddress,
                controller: provider.emailController,
              ),
              MobileInputView(
                phoneCtrl: provider.phoneController,
                callback: (String countryCode, String phone) {
                  provider.loginPhone = phone;
                  provider.loginCountryCode = countryCode;
                },
              ),
              LoginInputWidget(
                'Password',
                controller: provider.passwordController,
                prefixIcon: const Icon(
                  Icons.password_rounded,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              ButtonPrimaryWidget(
                'Register',
                onTap: () => provider.registerAction(context),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: SubTextHelper.SubText('OR', color: Colors.white),
              ),
              ButtonSecoundryWidget(
                'Login',
                onTap: () => GoTo.splashLogin(context),
              ),
              ButtonSecoundryWidget(
                "Continue as a Guest",
                onTap: () => GoTo.homeStudent(context),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
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
}
