import 'dart:async';

import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:need_resume/need_resume.dart';
import 'package:umq/next_page.dart';
import 'package:umq/tools/constant/EnvironmentConstant.dart';
import 'package:umq/tools/resourceProject/ColorProject.dart';
import 'package:umq/tools/resourceProject/FontProject.dart';

import 'tools/language/TranslateLangauge.dart';
import 'tools/resourceProject/DrawableProject.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends ResumableState<SplashScreen> {
  //--------------------------------------------------------------------- next page

  Future waitForSplashScreen() async {
    var time = 1000;
    Timer(Duration(milliseconds: time), () {
      nextPage();
    });
  }

  //------------------------------------------------------------------------ life cycle

  @override
  void initState() {
    super.initState();
    //  Log.i( "SplashScreenState - initState()");

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await TranslateLanguage.initializeApp(context);
      waitForSplashScreen();
    });
  }

  //-----------------------------------------------------------------------build ui

  @override
  Widget build(BuildContext context) {
    return PageFastor(
      this,
      content: contentPage(),
      homeButtonsBackgroundColor: HexColor(ColorProject.black_4),
      statusBarColorCustom: HexColor(ColorProject.black_4),
      colorBackground: HexColor(ColorProject.blue_fish_back),
    );
  }

  Widget contentPage() {
    return Stack(children: [
      EmptyView.allDeviceScreen(context),

      Positioned(
        left: 0,
        right: 0,
        top: 100,
        child: getImageLogo(),
      ), //top: 100*1.5,

      Positioned(bottom: 150, left: 0, right: 0, child: websiteName()),

      //test socket
      // testSocketNotification()
    ]);
  }

  Widget getImageLogo() {
    return ImageView(
        width: 150 * 1.5,
        height: 150 * 1.5,
        //width: 150*1.5, height: 77*1.5,
        assetAspectRatio: DrawableProject.images("logo"));
  }

  Widget websiteName() {
    var text = Text(EnvironmentConstant.website,
        style: TextStyle(
          fontSize: 35.0,
          fontFamily: FontProject.marina,
          color: HexColor(ColorProject.black_1),
          decoration: TextDecoration.none, // underline shape
          decorationColor:
              HexColor(ColorProject.blue_fish_front), //underline color
        ));
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      alignment: Alignment.center,
      child: text,
    );
  }

  //-------------------------------------------------------------------- test socket view

  /**
      Widget testSocketNotification() {
      //check not empty
      if( EnvironmentConstant.isLive) {
      return EmptyView.zero();
      }

      var txt =  TextTemplate.t( "socket: " + socket.toString(),
      width: 300, height: 300, levelDS: LevelDS.l2, color: Colors.black);
      return Positioned(child: txt, bottom: 250);
      }
   */
}
