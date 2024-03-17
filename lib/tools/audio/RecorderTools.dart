import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:umq/toolsUI/toast/ToastTools.dart';

class RecorderTools {

  /**
   * ture: means not allowed to record
   */
  static Future<bool> isPermissionDenied(BuildContext context, bool isPrintToastFailed ) async {
    //check mobile
    if (DeviceTools.isMobile() ) {
      bool isDenied = await Permission.microphone.isDenied;
      Log.i( "isPermissionDenied() - isDenied: " + isDenied.toString() );
      bool isGranted = await Permission.microphone.isGranted;
      Log.i( "isPermissionDenied() - isGranted: " + isGranted.toString() );

      var status =  await Permission.microphone.request();
      Log.i( "isPermissionDenied() - status: " + status.toString() );

      //check isPermanentlyDenied bug
      /**
       * this bug in package not determine it, just use native code ios to request dialog
       */
      if( status == Permission.microphone.isPermanentlyDenied ) {
        return false;
      }

      //toast failed
      if( isPrintToastFailed && isDenied ) {
      //  ToolsToast.i(context,  "Permission denied for Recorder");
      }
     return isDenied;
    }

    return false;
  }


}