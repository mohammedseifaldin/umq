import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/profile/data/model/m_user.dart';
import 'package:umq/toolsUI/admin/picker/user/PickerUserPage.dart';
import 'package:umq/toolsUI/toast/ToastTools.dart';

extension ExtensionRowButtonController on PickerUserState {
  //------------------------------------------------------------------- show product

  Future click_selected(MUser m) async {
    // Log.i( "click_selected - m: " + m.toString() );

    //success
    ToolsToast.i(context, "select, ${m.name!}");

    //wait
    ToolsWait.waitToDo(300, () {
      //finish curent page
      Navigator.pop(context);

      //call back
      widget.select(m);
    });
  }
}
