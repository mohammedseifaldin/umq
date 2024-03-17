import 'dart:async';

import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:need_resume/need_resume.dart';
import 'package:umq/tools/constant/EnvironmentConstant.dart';
import 'package:umq/tools/navigate/GoTo.dart';
import 'package:umq/tools/resourceProject/ColorProject.dart';
import 'package:umq/tools/resourceProject/DrawableProject.dart';
import 'package:umq/toolsUI/background/ScubaBackgroundImage.dart';

class SplashLoginPage extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends ResumableState<SplashLoginPage> {
  @override
  void initState() {
    super.initState();
    waitForSplashLogin();
  }

  late BuildContext context;

  //--------------------------------------------------------------------- system bar color + status bar

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return systemDeviceBar();
  }

  Widget systemDeviceBar() {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          systemNavigationBarColor: HexColor(ColorProject.blueTransparent),
        ),
        child: getScaffold());
  }

  Widget getScaffold() {
    return PageTemplate.t(
      this,
      statusBarColorCustom: HexColor(ColorProject.blueCerulean_3),
      content: getContentPage(),
      widgetBackground: ScubaBackgroundImage.getImageResponsive(context),
      //    assetBackground: DrawableProject.images_with_extension( "background_auth.jpeg" )
    );
  }

  //--------------------------------------------------------------------- content

  Widget getContentPage() {
    return Stack(children: [
      EmptyView.allDeviceScreen(context),

      // Positioned( child: logoIm(), left: 0, right: 0, top: 100,),

      Positioned(
        child: versionNumber(),
        left: 0,
        right: 0,
        bottom: 20,
      )
    ]);
  }

  Widget logoIm() {
    //return Center(   child: Image.asset('assets/images/logo.png') );
    var logo = ImageView(
      width: 300, //DeviceTools.get75PercentageWidth(context),
      height: 300, //DeviceTools.get75PercentageWidth(context) ,
      assetAspectRatio: DrawableProject.images("logo"),
    );

    return logo;
  }

  Widget versionNumber() {
    String msg = "version 1.0." + EnvironmentConstant.version.toString();
    return TextTemplate.t(msg,
        levelDS: LevelDS.l4,
        color: HexColor(ColorProject.white_sun_1),
        margin: EdgeInsets.only(bottom: 30));
  }

  waitForSplashLogin() async {
    var time = 1100 + 300;
    // if( EnvironmentConstant.isTest ) time = 300;

    //Log.i( "waitForSplashScreen() - start"  );
    Timer(Duration(milliseconds: time), () {
      // Log.i( "waitForSplashScreen() - end"  );
      GoTo.login(context);
    });
  }
}
