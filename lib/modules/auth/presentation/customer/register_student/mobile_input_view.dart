import 'package:fastor_app_ui_widget/resource/template/textfield/mobile/MobileCountryFastor.dart';
import 'package:fastor_app_ui_widget/resource/toolsFastor/device/DeviceTools.dart';
import 'package:flutter/material.dart';

import '../../../../../tools/resourceProject/FontProject.dart';
import '../../../../../toolsUI/ThemeColor.dart';

class MobileInputView extends StatelessWidget {
  final TextEditingController phoneCtrl;
  final Function(String, String) callback;
  const MobileInputView({
    super.key,
    required this.phoneCtrl,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(50.0)),
        color: ThemeColor.colorSecoundry.withOpacity(.5),
        border: Border.all(color: Colors.white, width: 0.5),
      ),
      child: MobileCountryFastor(
        width: DeviceTools.getWidth(context),
        colorUnderlineInputField: Colors.grey,
        favoriteCountryCodeArray: const ["+966", "+20"],
        textStyle: TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontFamily: FontProject.beach,
          decoration: TextDecoration.none,
        ),
        controller: phoneCtrl,
        callback: callback,
      ),
    );
  }
}
