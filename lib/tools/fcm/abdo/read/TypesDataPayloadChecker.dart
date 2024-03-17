

  //--------------------------------------------------------------------- data type


import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';

import '../general/m/MFcm.dart';


    bool isDataType_mail(MMessageFcm mFcm ) {
    return mFcm.messageRemote.data['type'] == 'mail';
  }

    bool isDataType_location(MMessageFcm mFcm ) {
    return mFcm.messageRemote.data['type'] == 'location';
  }


  bool isDataType_notify(MMessageFcm mFcm ) {
    return mFcm.messageRemote.data['type'] == 'notify';
  }

  bool isDataType_adminNotifiyUsers(MMessageFcm mFcm ) {
    return mFcm.messageRemote.data['type'] == 'admin';
  }

  bool isDataType_order(MMessageFcm mFcm ) {
    return mFcm.messageRemote.data['type'] == 'order';
  }


    bool isPathPayloadType__chat(String  payloadPath ) {
  return payloadPath.startsWith( "chat");
  }


    bool isPathPayloadType__admin(String  payloadPath ) {
  return payloadPath.startsWith( "admin");
  }


    String parsePayloadGetSenderId(String  payload ) {

  //check not have payload
  if ( ToolsValidation.isEmpty( payload)  ) {
    Log.i( "fcm - parsePayloadGetSenderId() - not have payload  "  );
  return "";
  }

  /**
      chat/{{senderId}}
   */
  int indexOfFirstBackslash = payload.indexOf( "/");
  var result = payload.substring(  indexOfFirstBackslash +1 );
  Log.i( "fcm - parsePayloadGetSenderId() - result: " + result  );
  return result;
  }
