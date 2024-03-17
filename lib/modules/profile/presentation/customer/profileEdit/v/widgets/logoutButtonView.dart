
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/profile/presentation/customer/profileEdit/v/edit_screen.dart';
import 'package:umq/tools/navigate/GoTo.dart';
import 'package:umq/toolsUI/dialog/MessageGeneralDialog.dart';
import 'package:umq/tools/cache/user_single_tone.dart';
import 'package:umq/tools/resourceProject/ColorProject.dart';


extension logoutButtonView on EditProfileState {

  Widget bt_logout(){
    return TextFastor(  "logout",

            onPressed: () async {

      await _openDilaogConfirmLogout();
    },
        fontSize: DSDimen.text_level_1,
        gravityLayoutAlign: Alignment.center,
        color: HexColor( ColorProject.red ),
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(vertical: DSDimen.space_level_2 - 10),
        levelDS: LevelDS.l1);
  }

  Future _openDilaogConfirmLogout() async {
    String title = "Logout Confirm";
    String msg = "Are you sure you want to logout from your account";
    MessageGeneralDialog.show(context, title, msg, (isClickOnYes) {
      if( isClickOnYes ) {
        _logoutFunction();
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