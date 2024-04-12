

  // //---------------------------------------------------------------------- chat parse methods tools
  //
  //    int getFCMGroupId(MMessageFcm mFcm ) {
  //
  //   //check not data
  //   if( mFcm.typeNotifyData == false )return 9999;
  //
  //   //check type "notify" chat
  //   if(   isDataType_notify(mFcm) == false  ) return 9999;
  //
  //   //check type  location
  //   if(   isDataType_location(mFcm) == false  ) return 9999;
  //
  //
  //   //check type  location
  //   if(   isDataType_mail(mFcm) == false  ) return 9999;
  //
  //   //read
  //   String read = mFcm.messageRemote.data["hashCode"];
  //   // Log.i( "fcm - getFCMGroupId() - read: " + read);
  //   int groupId =  int.parse( read);
  //   if( ToolsValidation.isZeroInt( groupId ) ) {
  //     Log.i( "fcm - getFCMGroupId() - error group id is empty");
  //     return 9999;
  //   }
  //   //  Log.i( "fcm - getFCMGroupId() - groupId " + groupId.toString() );
  //   return groupId;
  // }

