
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';

class TitleWidgetEditProfile extends StatelessWidget {
  const TitleWidgetEditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 24, bottom: 16),
      color: Colors.transparent,
      child: Center(
        child: getTitle(),
      ),
    );
  }

  Widget getTitle() {
    /*
    Text(
          "Edit Information",
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
            color: Colors.black,
          ),
        )
     */
    return TextTemplate.t(  "Edit Information", levelDS: LevelDS.l1 );
  }
}
