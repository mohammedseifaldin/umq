import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:need_resume/need_resume.dart';
import 'widget/login_form_widget.dart';
import '../../../provider/auth_change_notifier.dart';
import '../../../provider/login_notifier.dart';
import '../../../provider/register_notifier.dart';
import '../../../../../tools/constant/EnvironmentConstant.dart';
import '../../../../../tools/fcm/abdo/FCMRegister.dart';
import '../../../../../toolsUI/Widgets/button_primary_widget.dart';
import '../../../../../toolsUI/Widgets/button_secoundry_widget.dart';
import '../../../../../toolsUI/background/ScubaBackgroundImage.dart';
import '../../../../../toolsUI/textview/SubTextHelper.dart';

class LoginMobilePage extends StatefulWidget {
  const LoginMobilePage({super.key});

  @override
  LoginMobileState createState() => LoginMobileState();
}

class LoginMobileState extends ResumableState<LoginMobilePage> {
  //------------------------------------------------------------------------ variable

  AuthChangeNotifier? provider;

  //---------------------------------------------------------------------- life style

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      provider = AuthChangeNotifier.getListenFalse(context);
      provider!.setTimeZoneToCountry();
      await setupFcmFromMainPage(context);
    });
  }

  //-------------------------------------------------------------------------- build

  @override
  Widget build(BuildContext context) {
    provider = AuthChangeNotifier.getListenTrue(context);
    return PageTemplate.t(
      this,
      title: "Login",
      content: formBody(),
      widgetBackground: const ScubaBackgroundImage(),
      resizeToAvoidBottomInset: false,
    );
  }

  Widget formBody() {
    return Form(
      key: provider!.loginFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 120),
          TextFastor(
            "${EnvironmentConstant.appName} Account",
            fontSize: DSDimen.text_level_parent + 12,
            color: Colors.lightBlueAccent,
            fontFamily: "Mermaid Astramadea",
          ),
          const SizedBox(height: 20),
          loginEmail(),
          const SizedBox(height: 10),
          loginPassword(),
          const SizedBox(height: 10),
          ButtonPrimaryWidget(
            'Login',
            showProgress: provider!.loginProgress,
            onTap: () => provider!.loginAction(context),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: SubTextHelper.SubText('OR', color: Colors.white),
          ),
          ButtonSecoundryWidget(
            'New account',
            showProgress: provider!.loginProgress,
            onTap: () => provider!.createAccountAction(context),
          ),
          buttonGuest(),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
