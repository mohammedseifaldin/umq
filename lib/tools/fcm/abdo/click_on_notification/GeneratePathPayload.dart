
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';

import '../general/m/MFcm.dart';
import '../read/TypesDataPayloadChecker.dart';



  //------------------------------------------------------------------- path payload

    String generatePathPayloadScubaProject(MMessageFcm mFcm ) {

    //chat
    if( isDataType_notify( mFcm) ) {
      /**
       * foramte is
          chat/{{senderId}}
       */
      var result =  "chat/" + getSenderId(mFcm) ;
      Log.i( "fcm - generatePathPayload() - result: " + result );
      return result;
      //+ "/" + getMessageDatabaseId(mFcm ); >> /MessageId/
    }

    //admin notifiy
    if( isDataType_adminNotifiyUsers(mFcm)) {
      return "admin/";
    }


    //default
    return  mFcm.messageRemote.data.toString();
  }



//---------------------------------------------------------------------- chat parse methods tools

int getFCMGroupId(MMessageFcm mFcm ) {

  //check not data
  if( mFcm.typeNotifyData == false )return 999;

  //check type "notify" chat
  /**
      ['type'] == 'notify
   */
  if(  isDataType_notify(mFcm) == false  ) return 9999;

  //read
  String read = mFcm.messageRemote.data["group_notification"];
  // Log.i( "fcm - getFCMGroupId() - read: " + read);
  int groupId =  int.parse( read);
  if( ToolsValidation.isZeroInt( groupId ) ) {
    Log.i( "fcm - getFCMGroupId() - error group id is empty");
    return 999;
  }
  //  Log.i( "fcm - getFCMGroupId() - groupId " + groupId.toString() );
  return groupId;
}


String getSenderId(MMessageFcm mFcm ) {

  //check
  if( mFcm.typeNotifyData == false ) return  "888";

  //read
  String read = mFcm.messageRemote.data["sender_id"];
  //Log.i( "fcm - getSenderId() - read: " + read.toString() );

  if( ToolsValidation.isEmpty( read ) ) {
    Log.i( "fcm - getFCMGroupId() - error group id is empty");
    return "888";
  }
  return read.toString();
}


String getMessageDatabaseId(MMessageFcm mFcm ) {

  //check
  if( mFcm.typeNotifyData == false ) return  "777";

  //read
  String read = mFcm.messageRemote.data["msg_database_id"];
  //Log.i( "fcm - getMessageDatabaseId() - read: " + read.toString() );

  if( ToolsValidation.isEmpty( read ) ) {
    Log.i( "fcm - getMessageDatabaseId() - error group id is empty");
    return "777";
  }
  return read.toString();
}