import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/profile/data/source/UserCreateAPI.dart';
import 'package:umq/modules/profile/data/source/UserUpdateAPI.dart';
import 'package:umq/modules/profile/presentation/admin/user/detail/v/UserDetailAdminPage.dart';
import 'package:umq/tools/attachCapture/attach/AttachTools.dart';
import 'package:umq/tools/network/BackendConstant.dart';
import 'package:umq/tools/network/ToolsAPI.dart';
import 'package:umq/tools/resourceProject/DrawableProject.dart';
import 'package:umq/tools/values/ToolsValue.dart';
import 'package:umq/toolsUI/toast/ToastTools.dart';

extension ClickActionsUserDetails on UserDetailAdminState {
  //--------------------------------------------------------------------- save

  Future saveClick() async {
    Log.i("save_click() - ");

    //validate
    if (validate_save() == false) return;
    Log.i("save_click() - validate_save true");

    //choose type edit or create
    if (mEdit != null) {
      await _editPreviousAPI();
    } else {
      await _apiCreate();
    }
  }

  bool validate_save() {
    //name
    if (ToolsValidation.isName(name_txt) == false) {
      Log.i("validate_save() - missed - name ");
      ToolsToast.i(contextPage!, "Name Missed");
      setState(() {
        name_valid = AutovalidateMode.always;
      });
      return false;
    }

    //email
    if (ToolsValidation.isEmail(email_txt) == false) {
      Log.i("validate_save() - missed - email ");
      ToolsToast.i(contextPage!, "Email Missed");
      setState(() {
        email_valid = AutovalidateMode.always;
      });
      return false;
    }

    //city
    if (ToolsValue.isEmpty(city_selected_name)) {
      Log.i("validate_save() - missed - city ");
      ToolsToast.i(contextPage!, "city missed");
      return false;
    }

    //mobile
    /**
     the edit user not show mobile phone
     */
    if (mobileState != null) {
      String country = mobileState!.countryCode_text;
      String mobile = mobileState!.phone_text;
      if (ToolsValidation.isEmpty(country)) {
        Log.i("validate_save() - missed - Country ");
        ToolsToast.i(contextPage!, "Country Phone missed");
        return false;
      }
      if (ToolsValidation.isPhoneMobileValid(mobile) == false) {
        Log.i("validate_save() - missed - Mobile ");
        ToolsToast.i(contextPage!, "Mobile Missed");
        setState(() {
          mobileState!.setAutoValidteModeAlways();
        });
        return false;
      }
    }

    //photo "optional"
    /**
        if( ToolsValue.isEmpty( photo_url_selected) ) {
        ToolsToast.i(contextPage!, "photo missed");
        return false;
        }
     *
     */
    Log.i("validate_save() - return - (true) ");
    return true;
  }

  //--------------------------------------------------------------------------- create new object

  Future _apiCreate() async {
    if (prg != null) prg!.show();

    //get data
    String country = mobileState!.countryCode_text;
    String mobile = mobileState!.phone_text;
    await UserCreateAPI().getData(name_txt, email_txt, country, mobile,
        city_selected_id, photo_url_selected, (code, msg) {
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
    int targetUserId = mEdit!.id;
    await UserUpdateAPI().getData(
        targetUserId, name_txt, email_txt, city_selected_id, photo_url_selected,
        (code, msg) {
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

  //--------------------------------------------------------------- photo picker

  Future photo_click() async {
    //progress upload
    setState(() {
      photo_progress_status = true;
    });

    /**
     *     CaptureLaravel.typeUploadLaravel( urlApiLink,
     */
    await _listerUploadPhoto();
  }

  Future _listerUploadPhoto() async {
    //upload now
    String urlApiLink = BackendConstant.getUploadFileUrl();

    AttachTools.typeImageUploadLaravel(
        urlApiLink, DrawableProject.placeholderImage,
        (status, msg, pathFile, image, uploadedUrl) {
      //progress upload
      setState(() {
        photo_progress_status = false;
      });

      //check value
      if (status == false) {
        ToolsToast.i(context, msg);
        return;
      }
      if (ToolsValidation.isEmpty(uploadedUrl)) {
        return;
      }

      setState(() {
        photo_pathFile = pathFile;
        photo_url_selected = uploadedUrl;
        Log.i("success upload file: $uploadedUrl");

        photo_state!.setImageBackgroundUrl(uploadedUrl);
      });
    });
  }
}
