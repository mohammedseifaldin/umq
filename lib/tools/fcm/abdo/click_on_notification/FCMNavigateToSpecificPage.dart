
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/tools/navigate/GoTo.dart';

import '../FCMRegister.dart';
import '../read/TypesDataPayloadChecker.dart';



 clickNotificationHappened(  String? pathPayload ) {
    Log.i( "fcm - clickNotificationHappened() - pathPayload: " + pathPayload.toString() );

    //validate not found payload
    if( pathPayload == null ) {
      Log.i( "fcm - clickNotificationHappened() - payloadFcmClick == null - stop !");
      return;
    }

    //clear for next
    notificationPayloadStatic = null; //clear data for next time

    //validte not context page
    if( contextFcm == null ) {
      Log.i( "fcm - clickNotificationHappened() - context == null - stop");
        return;
    }

    //choose type
    bool isAdminPayload = isPathPayloadType__admin( pathPayload);
    bool isChatPayload = isPathPayloadType__chat( pathPayload); //ParsePathPayloadClicked.
    if(  isAdminPayload ) {
      _typeNavigate_admin(contextFcm!, pathPayload);

    } else if(isChatPayload ) {
      _typeNavigate_chat(contextFcm!, pathPayload);

    } else {
      GoTo.notificationListPage(contextFcm!);
    }

  }

  _typeNavigate_admin(BuildContext contextFcm, String? payloadFcmClick ) {

  //navigate
  GoTo.notificationListPage(contextFcm  );

  //clear for next
  notificationPayloadStatic = null; //clear data for next time
}


  _typeNavigate_chat(BuildContext contextFcm, String? payloadFcmClick ) {

  //parse sender id
  String senderIdFromPathPayload = parsePayloadGetSenderId(payloadFcmClick!);
  Log.i( "fcm - _typeNavigate_chat() - senderIdFromPathPayload " + senderIdFromPathPayload.toString() );

  //navigate
  int sender_id_integer = int.parse( senderIdFromPathPayload  );
  GoTo.chatSpecificUser(contextFcm , sender_id_integer  );

  //clear for next
  notificationPayloadStatic = null; //clear data for next time
}



