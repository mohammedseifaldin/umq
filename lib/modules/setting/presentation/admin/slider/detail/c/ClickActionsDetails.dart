import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/setting/presentation/admin/slider/detail/m/SlideCreateAPI.dart';
import 'package:umq/modules/setting/presentation/admin/slider/detail/m/SlideUpdateAPI.dart';
import 'package:umq/modules/setting/presentation/admin/slider/detail/v/SliderDetailAdminPage.dart';
import 'package:umq/tools/attachCapture/attach/AttachTools.dart';
import 'package:umq/tools/network/BackendConstant.dart';
import 'package:umq/tools/network/ToolsAPI.dart';
import 'package:umq/tools/resourceProject/DrawableProject.dart';
import 'package:umq/tools/values/ToolsValue.dart';
import 'package:umq/toolsUI/toast/ToastTools.dart';

extension ClickActionsDetails on SlideDetailAdminState {
  //--------------------------------------------------------------------- save

  Future save_click() async {
    FocusScope.of(context).unfocus();

    //validate
    if (validate_save() == false) return;

    //choose type edit or create
    if (mEdit != null) {
      await _editPreviousAPI();
    } else {
      await _apiCreate();
    }
  }

  bool validate_save() {
    //photo
    if (ToolsValue.isEmpty(photo_url_selected)) {
      ToolsToast.i(context, "photo missed");
      return false;
    }
    return true;
  }

  //--------------------------------------------------------------------------- create new object

  Future _apiCreate() async {
    if (prg != null) prg!.show();

    //get data
    await SlideCreateAPI().getData(photo_url_selected, (code, msg) {
      if (prg != null) prg!.dismiss();

      //check failed
      if (ToolsAPI.isFailed(code)) {
        ToolsToast.i(context, msg);
        return;
      }

      //success
      ToolsToast.i(context, msg);

      ToolsWait.waitToDo(300, () {
        //finish curent page
        Navigator.pop(context);
      });
    });
  }

  //---------------------------------------------------------------------- edit old object

  Future _editPreviousAPI() async {
    if (prg != null) prg!.show();

    //listener
    int targetUserId = mEdit!.id!;
    await SlideUpdateAPI().getData(targetUserId, photo_url_selected,
        (code, msg) {
      if (prg != null) prg!.dismiss();

      //check failed
      if (ToolsAPI.isFailed(code)) {
        ToolsToast.i(context, msg);
        return;
      }

      //success
      ToolsToast.i(context, msg);

      ToolsWait.waitToDo(300, () {
        //finish curent page
        Navigator.pop(context);
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
