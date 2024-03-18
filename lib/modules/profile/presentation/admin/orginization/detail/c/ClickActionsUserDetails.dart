import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/profile/data/source/OrgCreateAPI.dart';
import 'package:umq/modules/profile/data/source/OrgUpdateAPI.dart';
import 'package:umq/modules/profile/presentation/admin/orginization/detail/v/OrgDetailAdminPage.dart';
import 'package:umq/tools/network/ToolsAPI.dart';
import 'package:umq/toolsUI/toast/ToastTools.dart';

extension ClickActionsUserDetails on OrgDetailAdminState {
  //--------------------------------------------------------------------- save

  Future saveClick() async {
    FocusScope.of(contextPage!).unfocus();

    //validate
    if (validateSave() == false) return;

    //choose type edit or create
    if (mEdit != null) {
      await _editPreviousAPI();
    } else {
      await _apiCreate();
    }
  }

  bool validateSave() {
    //name en
    if (ToolsValidation.isName(nameEnText) == false) {
      ToolsToast.i(contextPage!, "Name En Missed");
      setState(() {
        nameEnValid = AutovalidateMode.always;
      });
      return false;
    }

    return true;
  }

  //--------------------------------------------------------------------------- create new object

  Future _apiCreate() async {
    if (prg != null) prg!.show();

    //get data
    await OrgCreateAPI().getData(nameEnText, (code, msg) {
      if (prg != null) prg!.dismiss();

      //check failed
      if (ToolsAPI.isFailed(code)) {
        ToolsToast.i(contextPage!, msg);
        return;
      }

      //success
      ToolsToast.i(contextPage!, msg);

      ToolsWait.waitToDo(300, () {
        //finish curent page
        Navigator.pop(contextPage!);
      });
    });
  }

  //---------------------------------------------------------------------- edit old object

  Future _editPreviousAPI() async {
    if (prg != null) prg!.show();

    //listener
    int target_user_id = mEdit!.id;
    await OrgUpdateAPI().getData(target_user_id, nameEnText, (code, msg) {
      if (prg != null) prg!.dismiss();

      //check failed
      if (ToolsAPI.isFailed(code)) {
        ToolsToast.i(contextPage!, msg);
        return;
      }

      //success
      ToolsToast.i(contextPage!, msg);

      ToolsWait.waitToDo(300, () {
        //finish curent page
        Navigator.pop(contextPage!);
      });
    });
  }
}
