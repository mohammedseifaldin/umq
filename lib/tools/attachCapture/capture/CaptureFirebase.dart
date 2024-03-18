
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:umq/tools/attachCapture/capture/CaptureTools.dart';

class CaptureFirebase {


  //------------------------------------------------------------------------- upload to firebase

  static Future<void> typeUploadFirebase(AssetImage placeHolder, PickerImageUploadCallBack callBack) async {

    //step : picker
    CaptureTools.typeCaptureOnly(placeHolder, (status, msg, filePath, image, xFile) {

      //check failed picked
      if( status == false ) {
        //return failed
        callBack(false, msg, "", image, "");
        return;
      }

      //step : upload
      _UploadFileAPIFirebase( filePath, image, xFile, callBack );

    }
    );
  }

  static _UploadFileAPIFirebase( String filePath, Image? image, XFile? xFile, PickerImageUploadCallBack callBack  ){

    //generate cloud path
    // String fileName = ToolsFile.getFileNameWithoutExtenstion( filePath );
    // String cloud = KeyFirebaseStorage.pickerImageUser + fileName;

    //listener
    /**
        UploadFileFirebaseAPI( cloud, filePath, xFile, (status, msg, url ) {

        //check failed
        if( status == false ) {
        callBack(false, msg, "", image, "");
        return;
        }

        //success
        callBack(true, "success", filePath, image, url );

        });
     */

  }

}