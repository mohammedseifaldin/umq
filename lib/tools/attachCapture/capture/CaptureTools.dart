import 'dart:io';

import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

// import 'package:universal_io/io.dart';

/**
 * @uploadedUrl : is the storage api return url of uploaded
 */
// typedef PickerImageUploadCallBack = Function(bool status, String msg, String filePath, Image image, String uploadedUrl );
// typedef PickerImageCallBack = Function(bool status, String msg, String filePath, Image image, Uint8List unitFile  );
typedef PickerImageUploadCallBack = Function(
    bool status, String msg, String filePath, Image? image, String uploadedUrl);
typedef PickerImageCallBack = Function(
    bool status, String msg, String filePath, Image? image, XFile? xFile);

//upload image while attach
/**
 *
    void pickerImageListener() {


    CaptureTools.pickerImageUpload( Drawable.account_tshirt_placeholder, (status, msg, filePath, image,   uploadedUrl ){

    //set result
    this.photo_pathFile = filePath;
    // this.unitFile = unitFile;

    if( status ) {
    imagePhotoState.setImage( image);
    } else {
    ToastTools.i( context,  msg );
    }

    });
    }
 */

class CaptureTools {
  //------------------------------------------------------------------------- picker only

  static Future<void> typeCaptureOnly(
      AssetImage placeHolder, PickerImageCallBack callBack) async {
    Image placeHolderImage = Image(image: placeHolder);

    try {
      XFile? photoPickered =
          await ImagePicker().pickImage(source: ImageSource.camera);

      //check mobile cancel picker image
      if (photoPickered == null) {
        Log.i("pickerImage() - photo == null - stop! ");
        //return failed
        callBack(false, "Picker Image canceled", "", placeHolderImage, null);
        return;
      }

      //get path
      Log.i("pickerImage() - photoPickered.path: " + photoPickered.path);

      //get image
      Image myImage;
      // Uint8List unitFile = await photoPickered.readAsBytes();
      // Log.i( "pickerImage() - unitFile: " + unitFile.toString()  );

      if (DeviceTools.isPlatformWeb()) {
        myImage = Image.network(photoPickered.path);
      } else {
        File myFile = File(photoPickered.path);
        myImage = Image.file(myFile);
      }

      //log

      /**
          Log.i( "pickerImage() - photoPickered: " + photoPickered.toString()  );
          Log.i( "pickerImage() - photoPickered.path: " + photoPickered.path  );
          Log.i( "pickerImage() - imagePickered: " + imagePickered.toString()  );
          Log.i( "pickerImage() - myImage: " + myImage.toString()  );
       */

      //success
      callBack(true, "success", photoPickered.path, myImage, photoPickered);
    } on PlatformException catch (e) {
      Log.i("pickerImage() - exc: " + e.toString());
      //return failed
      callBack(false, "Picker image failed, error: " + e.toString(), "",
          placeHolderImage, null);
      return;
    }
  }
}
