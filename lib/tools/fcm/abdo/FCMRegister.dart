
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../../firebase_options.dart';
import 'click_on_notification/FCMNavigateToSpecificPage.dart';
import 'click_on_notification/ListenerToSocketNavigate.dart';
import 'click_on_notification/SetupUserClickNotification.dart';
import 'general/ConstantFCM.dart';
import 'general/FCMSubscribe.dart';
import 'receiver/ReceiverFCM.dart';


  //-------------------------------------------------------------------- variable

  //public static data
  /**
   * the id of notification  when pushed
   */
    String? notificationPayloadStatic ;
    int? notificationPayloadIdStatic;

    BuildContext? contextFcm;

  //options
    const String drawableIconAndroid_packageFlutterLocal = '@drawable/notification_icon';
  // static const String drawableIconAndroid_packageAwesomeNotifications = 'resource://drawable/notification_icon';
  // static const String drawableIconAndroid_packageFlutterFCM = 'notification_icon';

  FirebaseMessaging?  messagingInstance;

  String fcmToken = "";


//---------------------------------------------------------------------  setup from main page

Future setupFcmFromMainMethod( ) async  {

  Log.i( "fcm - setupFcmFromMainMethod()");

  await  _initializeAtMainPageLikeHomeOrLogin();
  await _checkThereIsClickNotificationHappened();
}


Future setupFcmFromMainPage(BuildContext ctx) async  {
  contextFcm = ctx;
  //Log.i( "fcm - setupFcmFromMainPage() - ctx: $ctx");

  await  _initializeAtMainPageLikeHomeOrLogin();
  await _checkThereIsClickNotificationHappened();
}


Future _checkThereIsClickNotificationHappened()async{
  //show to ui
  if( notificationPayloadStatic != null  ) {
    Log.i( "fcm - setupFcmFromMainPage() - payload found data "   );
    clickNotificationHappened(    notificationPayloadStatic );
    notificationPayloadStatic = null;
    return;
  }
}

//------------------------------------------------------------------ init the fcm

Future _initializeAtMainPageLikeHomeOrLogin( ) async {

  //check initialized before
  if(messagingInstance != null ) {
    //Log.i( "fcm - _initializeAtMainPageLikeHomeOrLogin() - initialized before - stop !  "  );
    return;
  }


  await _setupFirebaseMessage();
  await _setupPackageFlutterLocalNotification();
}


  // It is assumed that all messages contain a data field with the key 'type'
  Future<void> _setupFirebaseMessage() async {
   Log.i( "fcm - setupInteractedMessage() - start  "  );

    //firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    //init objects
    messagingInstance  = FirebaseMessaging.instance;

    //setting general
    await _settingGranted();
    await _tokenFCMListener();
    await _badgeSetting();

    //receiver
    await receiverStateOnForGround();
    await receiverStateOnBackground();
    await receiverStateOnMessageOpenApp();

    //subscribe
    await FCMSubscribe.allUserSpecificPlatform( );

  }


  Future _tokenFCMListener()  async {


    String? currentToken = await FirebaseMessaging.instance.getToken();

    if( currentToken != null ) {
     Log.i("fcm - _tokenFCMListener() - currentToken: "  + currentToken.toString()  );
      Save.setString( ConstantFCM.fcm_token, currentToken);
    }

    FirebaseMessaging.instance.onTokenRefresh
        .listen((fcmToken) {
     Log.i("fcm - _tokenFCMListener() - fcmToken: " + fcmToken.toString() );
      Save.setString( ConstantFCM.fcm_token, fcmToken);
    })
        .onError((err) {
          Log.i("fcm - _tokenFCMListener() - err: " + err.toString() );
      // Error getting token.
    });
  }


  Future _settingGranted() async {
    /** - error print while app is at background
     *
        I/flutter (27049): #0      StandardMethodCodec.decodeEnvelope (package:flutter/src/services/message_codecs.dart:607:7)
        I/flutter (27049): #1      MethodChannel._invokeMethod (package:flutter/src/services/platform_channel.dart:177:18)
        I/flutter (27049): <asynchronous suspension>
        I/flutter (27049): #2      MethodChannel.invokeMapMethod (package:flutter/src/services/platform_channel.dart:377:43)
        I/flutter (27049): <asynchronous suspension>
        I/flutter (27049): #3      MethodChannelFirebaseMessaging.requestPermission (package:firebase_messaging_platform_interface/src/method_channel/method_channel_messaging.dart:270:36)
        I/flutter (27049): <asynchronous suspension>
        I/flutter (27049): #4      FCMRegister._settingGranted (package:granite/Tools/fcm/FCMRegister.dart:98:28)
        I/flutter (27049): <asynchronous suspension>
        I/flutter (27049): #5      FCMRegister.setupFirebaseMessage (package:granite/Tools/fcm/FCMRegister.dart:68:5)
        I/flutter (27049): <asynchronous suspension>
        I/flutter (27049): #6      FCMRegister.initializeApp (package:granite/Tools/fcm/FCMRegister.dart:46:5)
     */
    //setting permision
    // 3. On iOS, this helps to take the user permissions
    NotificationSettings settingsNotification = await messagingInstance!.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settingsNotification.authorizationStatus == AuthorizationStatus.authorized) {
      //  Log.i( "fcm - User granted permission");
      // TODO: handle the received notifications
    } else {
      Log.i( "fcm - _settingGranted() - declined or has not accepted permission");
    }
  }


  Future _badgeSetting() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }

  //--------------------------------------------------------------------------- setup : flutter_local_notification package

  //obj plugin
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future _setupPackageFlutterLocalNotification() async {


    //on click notification
    final NotificationAppLaunchDetails? notificationAppLaunchDetails = await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails() ;


    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      notificationPayloadStatic = notificationAppLaunchDetails!.notificationResponse!.payload;
      int? newPayloadId = notificationAppLaunchDetails.notificationResponse!.id;

      //validate have payload
      if( notificationPayloadStatic == null ) {
        Log.i( "fcm - didNotificationLaunchApp - payload == null - stop!  "  );
        return;
      }
      Log.i( "fcm - didNotificationLaunchApp - Payload: " + notificationPayloadStatic! );
      Log.i( "fcm - didNotificationLaunchApp - newPayloadId: " + newPayloadId.toString() );

      //validate already used before
      bool alreadyClickedBefore = newPayloadId == notificationPayloadIdStatic;
      if( alreadyClickedBefore ) {
        Log.i( "fcm - didNotificationLaunchApp - newPayloadId == payloadId - alreadyClickedBefore -  stop!  "  );
        return;
      }

      //set value id
      notificationPayloadIdStatic = newPayloadId;

      //handle foreground
      setupClickNotificationOnForegroundAndroid( notificationPayloadStatic);

    }



    //click on ios notification
    DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings( onDidReceiveLocalNotification:  ( int id, String? title, String? body, String? payload) async {
      if (payload != null) {
        Log.i('fmc - DarwinInitializationSettings - payload: $payload');
      }
      payload = payload;


      //handle foreground
      setupClickNotificationOnForegroundAndroid(payload);
    }) ;


    //setting
    const AndroidInitializationSettings initializationSettingsAndroid =  AndroidInitializationSettings('notification_icon');
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
     iOS: initializationSettingsIOS,
      // macOS: initializationSettingsMacOS,
      // linux: initializationSettingsLinux,
    );

    //select notification for ground
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: methodResponsePayload,
      onDidReceiveBackgroundNotificationResponse: methodResponsePayload
    );


    //create channel
    AndroidNotificationChannel defaultSingleChannelAndroid = const AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.max,
      playSound: true,

    );


    // set channel default
    if( DeviceTools.isAndroid() ) {
      await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()!
          .createNotificationChannel( defaultSingleChannelAndroid);
    }

  }

  // //for ios listenere click
  //   onDidReceiveLocalNotification(
  //     int id, String title, String body, String payload) async {
  //   // display a dialog with the notification  details, tap ok to go to another page
  //   if (payload != null) {
  //     Log.i('fmc - onSelectNotification - payload: $payload');
  //   }
  //   payload = payload;
  //
  //
  //   //handle foreground
  //   setupClickNotificationOnForegroundAndroid(payload);
  // }


  methodResponsePayload  (NotificationResponse details) async {
      if (details != null) {
        Log.i('fmc - methodResponsePayload - NotificationResponse: $details');
      }
      notificationPayloadStatic = details.payload;


      //handle foreground
      setupClickNotificationOnForegroundAndroid(notificationPayloadStatic);

    }

