import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/tools/fastor/drawable/FastorDrawable.dart';

class BackButtonChatView extends StatelessWidget {
  BuildContext pageContext;

  BackButtonChatView(this.pageContext, {super.key});

  @override
  Widget build(BuildContext context) {
    return padding();
  }

  Widget image() {
    //image
    return ImageView(
      width: 45,
      height: 40,
      padding: const EdgeInsets.all(10),
      margin: EdgeInsets.only(left: DSDimen.space_level_1),
      onPressed: () {
        Navigator.pop(pageContext);
      },
      assetAspectRatio: FastorDrawable.arrow_back_white,
    );
  }

  Widget padding() {
    //padding
    var padd = Container(
      child: image(),
      // width: 60,
      // color: Colors.yellow,
    );

    return GestureDetector(
        child: padd,
        onTap: () {
          Navigator.pop(pageContext);
        });
  }
}
