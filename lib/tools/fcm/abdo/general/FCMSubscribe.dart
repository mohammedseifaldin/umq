import 'dart:io';

import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:umq/tools/cache/user_single_tone.dart';


class FCMSubscribe {

  static Future allUserSpecificPlatform( ) async {

    /**
        avoid crash
        Error: UnimplementedError:  subscribeToTopic() is not supported on the web clients.

        To learn how to manage subscriptions for web users, visit the
        official Firebase documentation:

        https://firebase.google.com/docs/cloud-messaging/js/topic-messaging

        at Object.throw_ [as throw] (http://localhost:49373/dart_sdk.js:5405:11)
     */
    if(DeviceTools.isPlatformWeb() )return;

    //check subscribe before
    if( await FCMSubscribe.isSubscribeToAllUserBefore() ) {
      Log.i( "fcm - allUserSpecificPlatform() - isSubscribeToAllUserBefore -  stop !" );
      return;
    }

    //current platform //
    /**
     example android device:  fcm - allUserSpecificPlatform() - success key: android_all
     */
    String getPlatformName = FCMSubscribe._getPlatformName();
    String keySubscribe = getPlatformName + "_all"  ; //android_all
    await FirebaseMessaging.instance.subscribeToTopic( keySubscribe  ).then((value) {
      Log.i( "fcm - allUserSpecificPlatform() - success key: " + keySubscribe );

    });

    //any platform
    String keySubscribeAll = "all";
    await FirebaseMessaging.instance.subscribeToTopic( keySubscribeAll  ).then((value) {
      Log.i( "fcm - allUserSpecificPlatform() - success key: " + keySubscribeAll );
      setSubscribeToAllUserBefore();
    });
  }

  static Future userUpdateRole( ) async {
    //to user role
    String userRoleType = await  FCMSubscribe._generateKeyRoleType();
    await FirebaseMessaging.instance.subscribeToTopic( userRoleType ).then( (value){
      Log.i( "fcm - userUpdateRole() - userRoleType: " + userRoleType );
    });
  }


  static Future userRemoveRole( ) async {
    //to user role
    String userRoleType = await  FCMSubscribe._generateKeyRoleType();
    await FirebaseMessaging.instance.unsubscribeFromTopic( userRoleType ).then( (value){
      Log.i( "fcm - userRemoveRole() - userRoleType: " + userRoleType );
    });
  }

  /**
   * call after login
   */
  static Future userSpecificPlatform_add( ) async {
    /**
        avoid crash
        Error: UnimplementedError:  subscribeToTopic() is not supported on the web clients.

        To learn how to manage subscriptions for web users, visit the
        official Firebase documentation:

        https://firebase.google.com/docs/cloud-messaging/js/topic-messaging

        at Object.throw_ [as throw] (http://localhost:49373/dart_sdk.js:5405:11)
     */
    if(DeviceTools.isPlatformWeb() )return;

    //check is guest user
    if(await UserSingleTone.instance().isGuest() ) return;

    //current platform
    String keySubscribePlatfrom = await FCMSubscribe._generateKeyUserId_addPlatform();
    Log.i( "fcm - userSpecificPlatform_add() - keySubscribePlatfrom: " + keySubscribePlatfrom );
    await FirebaseMessaging.instance.subscribeToTopic( keySubscribePlatfrom).then( (value){
      Log.i( "fcm - userSpecificPlatform_add() - success - topic: " + keySubscribePlatfrom );
    });

    //any platform
    String keySubscribeOnly = await  FCMSubscribe._generateKeyUserId_only();
    await FirebaseMessaging.instance.subscribeToTopic( keySubscribeOnly ).then( (value){
      Log.i( "fcm - userSpecificPlatform_add() - keySubscribeOnly: " + keySubscribeOnly );
    });

    //to user role
    String userRoleType = await  FCMSubscribe._generateKeyRoleType();
    await FirebaseMessaging.instance.subscribeToTopic( userRoleType ).then( (value){
      Log.i( "fcm - userSpecificPlatform_add() - userRoleType: " + userRoleType );
    });
  }


  static Future userSpecificPlatform_remove( ) async {
    /**
        avoid crash
        Error: UnimplementedError:  subscribeToTopic() is not supported on the web clients.

        To learn how to manage subscriptions for web users, visit the
        official Firebase documentation:

        https://firebase.google.com/docs/cloud-messaging/js/topic-messaging

        at Object.throw_ [as throw] (http://localhost:49373/dart_sdk.js:5405:11)
     */
    if(DeviceTools.isPlatformWeb() )return;


    //check is guest user
    if(await UserSingleTone.instance().isGuest() ) return;

    try{
      //current platform
      String keySubscribePlatfrom = await  FCMSubscribe._generateKeyUserId_addPlatform();
      await FirebaseMessaging.instance.unsubscribeFromTopic( keySubscribePlatfrom ).then( (value){
        Log.i( "fcm - userSpecificPlatform_remove() - keySubscribePlatfrom: " + keySubscribePlatfrom );
      });

      //any platform
      String keySubscribeOnly = await  FCMSubscribe._generateKeyUserId_only();
      await FirebaseMessaging.instance.unsubscribeFromTopic( keySubscribeOnly ).then( (value){
        Log.i( "fcm - userSpecificPlatform_remove() - keySubscribeOnly: " + keySubscribeOnly );
      });

      //to user role
      String userRoleType = await  FCMSubscribe._generateKeyRoleType();
      await FirebaseMessaging.instance.unsubscribeFromTopic( userRoleType ).then( (value){
        Log.i( "fcm - userSpecificPlatform_remove() - userRoleType: " + userRoleType );
      });

    } catch ( e ){
      Log.i( "fcm - userSpecificPlatform_remove() - catch e: " + e.toString() );
    }

  }

  //--------------------------------------------------------------------------- tools

  static final keyAll = "setSubscribeToAllUserFCM_2";

  static void setSubscribeToAllUserBefore(){
    Save.setBool( keyAll, true );
  }


  static Future< bool > isSubscribeToAllUserBefore() async{
    return await Save.getBool( keyAll );
  }


  /**
      android_id_16
   */
  static Future<String> _generateKeyUserId_addPlatform() async {
    String getPlatformName = FCMSubscribe._getPlatformName();
    String userId = await  _generateKeyUserId_only();
    return getPlatformName + "_"  + userId;
  }


  static Future<String> _generateKeyUserId_only() async {
    int userId = await  UserSingleTone.instance().getUserId();
    return "id_" + userId.toString()  ;
  }

  static Future<String> _generateKeyRoleType() async {
    String nameRole = await  UserSingleTone.instance().getRole();
    return "role_" + nameRole.toString()  ;
  }


  static String _getPlatformName(){
    String name = "";

    if( DeviceTools.isAndroid() ){
      name = "android";
    } else if ( DeviceTools.isIOS() ) {
      name = "ios";
    } else {
      name = "web";
    }
    return name;
  }


}