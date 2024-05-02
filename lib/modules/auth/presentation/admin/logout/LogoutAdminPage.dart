import 'dart:async';


import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/tools/navigate/GoToAdmin.dart';
import 'package:umq/tools/navigate/GoTo.dart';
import 'package:umq/toolsUI/dialog/MessageGeneralDialog.dart';
import 'package:umq/tools/cache/user_single_tone.dart';
import 'package:umq/tools/resourceProject/ColorProject.dart';


class LogoutAdminPage extends StatefulWidget {


  @override
  LogoutAdminState createState() {
    return LogoutAdminState();
  }

}

class LogoutAdminState extends State<LogoutAdminPage> {

  @override
  void initState() {
    super.initState();
    waitForSplashScreen();
  }

  @override
  Widget build(BuildContext context) {
    return PageTemplate.t( this,
        title: "Logout",
        colorBackground: HexColor( ColorProject.blueTransparent),
        content: pageContent() );
  }

  Widget pageContent(){
    return EmptyView.allDeviceScreen(context);
  }


  waitForSplashScreen() async {

    var time = 400;
    //Log.i( "waitForSplashScreen() - start"  );
    Timer(Duration(milliseconds: time), () {
      // Log.i( "waitForSplashScreen() - end"  );

      _openDilaogConfirmLogout();

    });

  }


  Future _openDilaogConfirmLogout() async {
    String title = "Logout Confirm";
    String msg = "Are you sure you want to logout from your account";
    MessageGeneralDialog.show(context, title, msg, (isClickOnYes) {
      if( isClickOnYes ) {
        _logoutFunction();
      } else {

        //now dismiss current
        GoToAdmin.dashboard(context);
      }
    });
  }


  void _logoutFunction() {
    //remove cache
    UserSingleTone.instance().setLogout();

    //wait to remove cache
    ToolsWait.waitToDo(100, ()  {
      GoTo.splashApp( context);
    });
  }


}