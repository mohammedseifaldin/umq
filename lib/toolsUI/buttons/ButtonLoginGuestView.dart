import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/tools/navigate/GoTo.dart';
import 'package:umq/tools/resourceProject/ColorProject.dart';

class ButtonLoginGuestView extends StatelessWidget {
  BuildContext pageContext;

  ButtonLoginGuestView(this.pageContext, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextTemplate.t("Login to your Account", onPressed: () {
      GoTo.splashLogin(pageContext);
    },
        textAlign: TextAlign.center,
        color: HexColor(ColorProject.blue_fish_front),
        margin: const EdgeInsets.all(20));
  }
}
