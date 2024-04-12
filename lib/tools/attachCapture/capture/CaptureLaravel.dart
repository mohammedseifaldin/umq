import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:umq/tools/attachCapture/capture/CaptureTools.dart';
import 'package:umq/tools/laravel/upload/UploadFileLaravelAPI.dart';

class CaptureLaravel {
  //------------------------------------------------------------------------- upload to laravel

  static Future<void> typeUploadLaravel(String urlAPILink,
      AssetImage placeHolder, PickerImageUploadCallBack callBack) async {
    //step : picker
    await CaptureTools.typeCaptureOnly(placeHolder,
        (status, msg, filePath, image, xFile) async {
      //check failed picked
      if (status == false) {
        //return failed
        callBack(false, msg, "", image, "");
        return;
      }

      //step : upload
      await _UploadFileAPILaravel(urlAPILink, filePath, image, xFile, callBack);
    });
  }

  static Future _UploadFileAPILaravel(String urlAPILink, String filePath,
      Image? image, XFile? xFile, PickerImageUploadCallBack callBack) async {
    //listener
    await UploadFileLaravelAPI().getDataByXFile(
        urlAPILink: urlAPILink,
        xFile: xFile!,
        callBack: (status, msg, responseLaravelUpload) {
          //check failed
          if (status == false) {
            callBack(false, msg, "", image, "");
            return;
          }

          //success
          callBack(true, "success", filePath, image,
              responseLaravelUpload.data!.path!);
        });
  }
}
