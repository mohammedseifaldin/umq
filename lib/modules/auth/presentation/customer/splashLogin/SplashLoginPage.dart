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
  const SplashLoginPage({super.key});

  @override
  PageState createState() => PageState();
}

class PageState extends ResumableState<SplashLoginPage> {
  @override
  void initState() {
    super.initState();
    waitForSplashLogin();
  }

  //--------------------------------------------------------------------- system bar color + status bar

  @override
  Widget build(BuildContext context) {
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
      widgetBackground: const ScubaBackgroundImage(),
      resizeToAvoidBottomInset: false,
    );
  }

  //--------------------------------------------------------------------- content

  Widget getContentPage() {
    return Stack(children: [
      EmptyView.allDeviceScreen(context),
      Positioned(
        left: 0,
        right: 0,
        bottom: 20,
        child: versionNumber(),
      )
    ]);
  }

  Widget logoIm(BuildContext context) {
    return ImageFastor(
      width: 300,
      height: 300,
      context: context,
      assetAspectRatio: DrawableProject.images("logo"),
    );
  }

  Widget versionNumber() {
    String msg = "version 1.0.${EnvironmentConstant.version}";
    return TextTemplate.t(msg,
        levelDS: LevelDS.l4,
        color: HexColor(ColorProject.white_sun_1),
        margin: const EdgeInsets.only(bottom: 30));
  }

  waitForSplashLogin() async {
    Timer(const Duration(milliseconds: 1400), () {
      GoTo.login(context);
    });
  }
}
