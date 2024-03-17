import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';

import 'package:umq/toolsUI/ThemeColor.dart';

typedef callback = Function();

class ButtonSecoundryWidget extends StatelessWidget {
  String title;
  callback? onTap;
  double fontSize;
  var leading;
  bool? showProgress;


  ButtonSecoundryWidget(this.title, {
    this.fontSize = 18,
    this.onTap,
    this.showProgress,
    this.leading}){

    showProgress ??= false;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.1, 0.5],
            colors: [
              ThemeColor.hexToColor('#ffffff'),
              ThemeColor.hexToColor('#ffffff'),
            ],
          ),
          borderRadius: BorderRadius.all(Radius.circular(50))),
      child:  showProgress!? _progressView() : _buttonContent(),
    );
  }

  _progressView(){
    var prg = ProgressCircleFastor( size: fontSize,);
    return Container(
      child: prg,
      alignment: Alignment.center,
    );
  }

  Widget _buttonContent(){
    return GestureDetector(
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
                fontFamily: 'Schyler',
                decoration: TextDecoration.none,
                color: Colors.black),
          )
        ],
      ),
      onTap: onTap,
    );
  }


}
