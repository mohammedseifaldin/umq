import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/notification/data/response/ResponseNotificationAdminSingle.dart';
import 'package:umq/modules/notification/data/source/NotificationCreateAPI.dart';
import 'package:umq/modules/notification/presentation/admin/detail/v/NotificationCreateAdminPage.dart';
import 'package:umq/toolsUI/toast/ToastTools.dart';

extension ClickActionsUserDetails on NotificationCreateAdminState {
  //--------------------------------------------------------------------- save

  Future saveClick() async {
    FocusScope.of(context).unfocus();

    //validate
    if (validate_save() == false) return;

    await _apiCreate();
  }

  bool validate_save() {
    // //topicSelected
    // if( ToolsValidation.isValid(topicSelected) == false ) {
    //   ToolsToast.i(context,  "Target Missed");
    //   return false;
    // }

    //name
    if (ToolsValidation.isName(title_txt) == false) {
      ToolsToast.i(context, "Name En Missed");
      setState(() {
        title_valid = AutovalidateMode.always;
      });
      return false;
    }

    //name
    if (ToolsValidation.isName(message_txt) == false) {
      ToolsToast.i(context, "Name Ar Missed");
      setState(() {
        message_valid = AutovalidateMode.always;
      });
      return false;
    }

    return true;
  }

  //--------------------------------------------------------------------------- create new object

  Future _apiCreate() async {
    if (prg != null) prg!.show();

    //choose type
    if (userSelected != null) {
      await NotificationCreateAPI()
          .toSpecificUser(userSelected!, title_txt, message_txt, myCallBack);
    } else {
      await NotificationCreateAPI()
          .toAllUser("all", title_txt, message_txt, myCallBack);
    }
  }

  //NotificationCreateAPICallBack

  void myCallBack(
      bool status, String msg, ResponseNotificationAdminSingle response) {
    if (prg != null) prg!.dismiss();

    //check failed
    if (status == false) {
      ToolsToast.i(context, msg);
      return;
    }

    //success
    ToolsToast.i(context, msg);

    //wait
    ToolsWait.waitToDo(300, () {
      //finish curent page
      Navigator.pop(context);
    });
  }
}
