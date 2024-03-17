import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/tools/resourceProject/FontProject.dart';
import 'package:umq/toolsUI/ThemeColor.dart';

typedef callback = Function();

class ButtonPrimaryWidget extends StatelessWidget {
  String title;
  callback? onTap;
  double fontSize;
  var leading;
  bool? showProgress;

  ButtonPrimaryWidget(this.title, {
    this.fontSize = 18,
    this.showProgress,
    this.onTap,
    this.leading
  }){
    showProgress ??= false;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.1, 0.5, 0.7],
            colors: [
              ThemeColor.hexToColor('#05A8F1'),
              ThemeColor.hexToColor('#005190'),
              ThemeColor.hexToColor('#09265F'),
            ],
          ),
          borderRadius: BorderRadius.all(Radius.circular(50))),
      child: showProgress!? _progressView() : _buttonContent(),
    );

  }

  _progressView(){
    var prg = ProgressCircleFastor( size: fontSize,);
    return Container(
      child: prg,
      alignment: Alignment.center,
    );
  }

  _buttonContent() {
   return GestureDetector(
       onTap: onTap,
       child: Row(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           if (leading != null) leading,
           if (leading != null)
             SizedBox(
               width: 10,
             ),
           Text(
             title,
             textAlign: TextAlign.center,
             style: TextStyle(
                 fontSize: fontSize,
                 fontStyle: FontStyle.normal,
                 fontWeight: FontWeight.bold,
                 fontFamily: FontProject.beach,
                 decoration: TextDecoration.none,
                 color: Colors.white),
           )
         ],
       )
   );
  }
}
