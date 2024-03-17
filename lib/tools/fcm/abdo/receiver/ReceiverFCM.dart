import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';


import '../FCMRegister.dart';
import '../general/m/MFcm.dart';
import '../read/ReadTypeFCM.dart';

//----------------------------------------------------------------------- receiver state background

/**
    /// This provided handler must be a top-level function and cannot be
    /// anonymous otherwise an [ArgumentError] will be thrown.
 */
Future receiverStateOnBackground() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  } catch ( e) {
    Log.i( "fcm - receiverStateOnBackground() - e " + e.toString() );
  }

}


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage messageRemote) async {
  Log.i( "fcm - _firebaseMessagingBackgroundHandler() - messageRemote " + messageRemote.toString() );
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  /**
   avoid there is doublicate message
      var mFCM = MMessageFcm( messageRemote);
      mFCM.receivedStateTypeBackGround = true;

      //read and push
      await readTypeNotification( mFCM);
   */


}


//----------------------------------------------------------------------- receiver state forGround

  Future receiverStateOnForGround() async {
   // Log.i( "fcm - receiverStateOnForGround() - start "  );
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {

      _handleMessageForGround(message);

      refreshNotificationBadgeCounter();
    });
  }

  /**
      handle the fcm data
   */
  Future _handleMessageForGround(RemoteMessage messageRemote  )  async {
    Log.i( "fcm - _handleMessageForGround() - RemoteMessage: " + messageRemote.toString() );

    var mFCM = MMessageFcm( messageRemote);
    mFCM.receivedStateTypeForGround = true;

    //read
    await readTypeNotification( mFCM);

  }

  //-------------------------------------------------------------------- counter

  Future refreshNotificationBadgeCounter() async {
    Log.i( "fcm - refreshNotificationBadgeCounter() - contextFcm: " + contextFcm.toString() );
    if( contextFcm == null ) return;
    // NotificationCubit.get(contextFcm).getUnReadCounter();
  }

  //--------------------------------------------------------------------- state: message open app


  Future receiverStateOnMessageOpenApp() async {
    FirebaseMessaging.onMessageOpenedApp.listen(_handleOnMessageOpenedApp);
  }


  Future _handleOnMessageOpenedApp(RemoteMessage messageRemote ) async {

    Log.i( "fcm - _handleOnMessageOpenedApp() - RemoteMessage: " + messageRemote.toString() );
    var mFCM = MMessageFcm( messageRemote);
    mFCM.receivedStateTypeUserClickOnNotification = true;

    //read
    await readTypeNotification( mFCM);
  }

