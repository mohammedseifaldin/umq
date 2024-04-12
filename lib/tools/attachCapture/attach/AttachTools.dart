import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:umq/tools/attachCapture/capture/CaptureTools.dart';
import 'package:umq/tools/laravel/upload/UploadFileLaravelAPI.dart';

class AttachTools {
  static Future typeImageUploadLaravel(
    String urlAPILink,
    AssetImage placeHolder,
    PickerImageUploadCallBack callBack, {
    Map<String, String>? bodyRequest,
  }) async {
    //step: attach file
    await typePickerFile(placeHolder,
        (status, msg, filePath, image, xFile) async {
      //check failed picked
      if (status == false) {
        //return failed
        callBack(false, msg, "", image, "");
        return;
      }

      //step : upload
      await _UploadFileAPILaravel(urlAPILink, filePath, image, xFile, callBack,
          bodyRequest: bodyRequest);
    });
  }

  static Future typePickerFile(
      AssetImage placeHolder, PickerImageCallBack callBack) async {
    Log.i("_pickerFile() - start ");
    Image placeHolderImage = Image(image: placeHolder);

    try {
      // Uint8List? unitFile;
      // Image myImage;
      XFile? xFile = await ImagePicker().pickImage(source: ImageSource.gallery);

      //check mobile cancel picker image
      if (xFile == null) {
        Log.i("_pickerFile() - photo == null - stop! ");
        //return failed
        callBack(false, "Picker Image canceled", "", placeHolderImage, null);
        return;
      }

      // myImage  =  Image.file( myFile) ;

      // unitFile = await xFile.readAsBytes();

      //log
      /**
          Log.i( "_pickerFile() - photoPickered: " + photoPickered.toString()  );
          Log.i( "_pickerFile() - photoPickered.path: " + photoPickered.path  );
          Log.i( "_pickerFile() - imagePickered: " + imagePickered.toString()  );
          Log.i( "_pickerFile() - myImage: " + myImage.toString()  );
       */

      //success
      callBack(true, "success", xFile.path, null, xFile);
    } on PlatformException catch (e) {
      Log.i("_pickerFile() - exc: $e");
      //return failed
      callBack(
          false, "Picker image failed, error: $e", "", placeHolderImage, null);
      return;
    }
  }

  static Future _UploadFileAPILaravel(
    String urlAPILink,
    String filePath,
    Image? image,
    XFile? xFile,
    PickerImageUploadCallBack callBack, {
    Map<String, String>? bodyRequest,
  }) async {
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
      },
    );
  }
}
