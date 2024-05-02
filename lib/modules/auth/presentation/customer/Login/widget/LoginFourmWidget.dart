import 'package:country_code_picker/country_code_picker.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/auth/presentation/customer/Login/login_page.dart';
import 'package:umq/tools/navigate/GoTo.dart';
import 'package:umq/tools/resourceProject/FontProject.dart';
import 'package:umq/toolsUI/ThemeColor.dart';
import 'package:umq/toolsUI/Widgets/button_secoundry_widget.dart';
import 'package:umq/toolsUI/Widgets/login_input_widget.dart';

extension LoginFourmWidget on LoginMobileState {
  Widget buttonGuest() {
    return ButtonSecoundryWidget("Continue as a Guest", onTap: () {
      GoTo.homeStudent(context);
    });
  }

  Widget mobileInputView() {
    var tfPhone = MobileCountryFastor(
      width: DeviceTools.getWidth(context),
      colorUnderlineInputField: Colors.grey,
      favoriteCountryCodeArray: const ["+966", "+20"],
      textStyle: TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontFamily: FontProject.beach,
          decoration: TextDecoration.none),
      controller: provider!.emailController,
      // title: "ENTER PHONE NUMBER",
      callback: (String countryCode, String phone) {
        Log.i("selected - country_code: $countryCode /phone: $phone");
        // cubit!.requestRegister.countryCode = country_code;
        // cubit!.requestRegister.phoneNumber = phone;
        provider!.loginPhone = countryCode + phone;
        provider!.loginCountryCode = countryCode;
      },
    );

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(50.0)),
        color: ThemeColor.colorSecoundry.withOpacity(.5),
        border: Border.all(color: Colors.white, width: 0.5),
      ),
      child: tfPhone,
    );
  }

  Widget loginEmail() {
    return LoginInputWidget(
      'Email',
      controller: provider!.emailController,
      inputType: TextInputType.emailAddress,
      prefixIcon: const Icon(
        Icons.email_rounded,
        color: Colors.white,
      ),
    );
  }

  Widget loginPassword() {
    return LoginInputWidget(
      'Password',
      controller: provider!.passwordController,
      prefixIcon: const Icon(
        Icons.password_rounded,
        color: Colors.white,
      ),
    );
  }

  Widget countryPickerPrefixIcon() {
    return CountryCodePicker(
      flagWidth: 20,
      textStyle: const TextStyle(color: Colors.white),
      favorite: const ["+966", "+20"],
      onChanged: (country) {
        Log.i("selected - country.dialCode: ${country.dialCode}");
        provider!.loginCountryCode = country.dialCode!;
      },
      initialSelection: provider!
          .loginCountryCode, // example " +20" cause set on create view egypt flag
      showFlag: true,
      showFlagDialog: true,
      comparator: (a, b) => b.name!.compareTo(a.name!),
      //Get the country information relevant to the initial selection
    );
  }
}
