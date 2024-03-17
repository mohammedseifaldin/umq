
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:umq/tools/File/ToolsFile.dart';

import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/tools/attachCapture/capture/CaptureTools.dart';

import 'package:umq/tools/firebase/storage/KeyFirebaseStorage.dart';
import 'package:umq/tools/firebase/storage/UploadFileFirebaseAPI.dart';

import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io';

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
    String fileName = ToolsFile.getFileNameWithoutExtenstion( filePath );
    String cloud = KeyFirebaseStorage.pickerImageUser + fileName;

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