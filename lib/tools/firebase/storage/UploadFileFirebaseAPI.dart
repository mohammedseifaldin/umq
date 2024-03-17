
/*
import 'dart:async';

import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/tools/network/InternetTools.dart';
import 'package:umq/tools/values/ToolsValue.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


// import 'package:universal_html/html.dart' as html ;
import 'package:universal_io/io.dart' as universal_io ;
import 'dart:io' as io;

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

typedef UploadFileFirebaseCallBack = Function(bool status, String msg, String url);

class UploadFileFirebaseAPI {

  //------------------------------------------------------------------------ variable

  static String tag = "UploadFileFirebaseAPI";

  String pathCloud = ""; //pages "/notes/file.txt"
  String pathFile = ""; //for mobile only
  Uint8List unitFile = Uint8List(0);  //for web only
  UploadFileFirebaseCallBack callBack;

  //web variable
  String extensionName ;


  //variable
  late firebase_storage.Reference ref ;
  late String url;

  //------------------------------------------------------------------------ constructor

  UploadFileFirebaseAPI(this.pathCloud, this.pathFile, this.unitFile, this.callBack,{
    String this.extensionName = ".png"
  }) {

    onCreate();
  }



  onCreate() {
    //validate
    if (validate() == false ) {
      return;
    }

    //log
    //Log.k(tag,  "constructor() - pathCloud: " + pathCloud );
    // Log.k(tag,  "constructor() - pathFile: " + pathFile );


    //check internet
    checkInternet();
  }

  //------------------------------------------------------------------------ validate

  bool validate() {

    //pathCloud
    if( ToolsValue.isEmpty( pathCloud ) ) {
      String msg = "PathCloud is null";
      finish_failed(msg);
      return false;
    }

    // //pathFile
    // if( ToolsValue.isEmpty( pathFile ) ) {
    //   String msg = "pathFile is null";
    //   finish_failed(msg);
    //   return false;
    // }
    return true;
  }

  Future checkInternet() async {
    await InternetTools.isConnected().then((value) {
      if( value ) {
        uploadFileChoosePlatform();
      } else {
        finish_failed( "No Internet Connection!");
      }
    });
  }

  //------------------------------------------------------------------------ upload


  Future<void> uploadFileChoosePlatform( ) async {

    try {
      if( DeviceTools.isPlatformWeb() ) {
        uploadFileToWeb();
      } else {
        uploadFileToMobile();
      }
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      String msg = e.toString();
      Log.k( tag, "uploadFile() - FirebaseException: " + e.toString() );
      finish_failed( msg );
    } on Exception catch(e) {
      Log.k( tag, "uploadFile() - exc: " + e.toString() );
      String msg = e.toString();
      finish_failed( msg );
    }

  }


  Future uploadFileToMobile() async {
    //set
    ref =  firebase_storage.FirebaseStorage.instance.ref( pathCloud ); //'/notes.txt'
    io.File file = io.File(  pathFile );
      await ref.putFile(file).whenComplete(() => generateDownloadUrl() );
  }


  Future uploadFileToWeb()  async {
    // fix extenstion file name not found
    /**
     * the lib attach file in web save the photo at cache without extenstion
     */
    pathCloud += extensionName;
    Log.k(tag,  "uploadFileToWeb() - fix cloud: " + pathCloud  );

    //set
    ref =  firebase_storage.FirebaseStorage.instance.ref( pathCloud );
    await ref.putData(
      unitFile,
      SettableMetadata(contentType: 'image/jpeg'), //jpeg
    ).whenComplete(() => generateDownloadUrl() );
  }

  //------------------------------------------------------------------- generate url

  Future generateDownloadUrl() async {
    // Log.k( tag, "generateDownloadUrl() - start  "   );
    // Log.k( tag, "generateDownloadUrl() - start  - ref: " + ref.toString()  );

    await ref.getDownloadURL().then((downloadUrl) {
      url = downloadUrl;
      Log.k( tag, "generateDownloadUrl() - url: " + url );
      finish_success();
    }).catchError((onError) {
      String msg =  "Got Error $onError";
      finish_failed( msg );
    });
  }

  //--------------------------------------------------------------------- finish

  void finish_failed(String msg) {
    Log.k(tag,  "finish_failed() - msg: " + msg );
    callBack(false, msg, "");
  }

  void finish_success() {
   Log.k(tag,  "finish_success() - url: " + url );
    callBack(true, "success", url);
  }

}


 */