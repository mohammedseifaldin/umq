import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:umq/tools/resourceProject/ColorProject.dart';
import 'package:umq/tools/constant/EnvironmentConstant.dart';

import '../FCMRegister.dart';
import '../click_on_notification/GeneratePathPayload.dart';
import '../general/m/MFcm.dart';

//------------------------------------------------------------------------- package: local_notification_flutter

Future pushByLocalNotification(MMessageFcm mFcm) async {
  //delete old
  await deleteOldFCMGroupId(mFcm);

  //print working in background
  _printSourceDebug(mFcm);

  //set every platform
  var _androidDetail;
  if (DeviceTools.isAndroid()) {
    _androidDetail = _androidNotificationDetails(mFcm);
  }
  /**
        var _iosDetail ;
        if( DeviceTools.isIOS() ) {
        _iosDetail = _iosNotificationDetail( mFcm );
        }
     */

  //push local notification
  FlutterLocalNotificationsPlugin().show(
    mFcm.messageRemote.hashCode,
    mFcm.title,
    mFcm.body,
    NotificationDetails(
      android: _androidDetail,
      // iOS: _iosDetail
    ),
    payload: generatePathPayloadScubaProject(mFcm),
  );
}

AndroidNotificationDetails _androidNotificationDetails(MMessageFcm mFcm) {
  //generate channel
  String fcmGroupId = getFCMGroupId(mFcm).toString();
  AndroidNotificationChannel _singleChannel =
      generateAndroidSingleChannel(fcmGroupId);

  // set channel
  FlutterLocalNotificationsPlugin()
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()!
      .createNotificationChannel(_singleChannel);

  return AndroidNotificationDetails(
    _singleChannel.id,
    "Description FCM Group",
    color: HexColor(ColorProject.blue_fish_back),
    icon:
        drawableIconAndroid_packageFlutterLocal, // "@drawable/notification_icon",
    priority: Priority.max,
    //  groupKey : fcm_group_id, //FCMRegister.groupAndroid.id,
  );
}

AndroidNotificationChannel generateAndroidSingleChannel(String fcm_group_id) {
  // Log.i( "generateAndroidSingleChannel() - channelId: " + fcm_group_id );
  return AndroidNotificationChannel(fcm_group_id, "Description FCM Group",
      importance: Importance.max, playSound: true);
}

Future deleteOldFCMGroupId(MMessageFcm mFcm) async {
  String channelId = getFCMGroupId(mFcm).toString();
  // Log.i( "fcm - deleteOldFCMGroupId() - channelId: " + channelId );

  //case android
  if (DeviceTools.isAndroid()) {
    await FlutterLocalNotificationsPlugin()
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.deleteNotificationChannel(channelId);
    return;
  }

  // //case ios
  // if( DeviceTools.isAndroid() ) {
  //   var iosPlugin = IOSFlutterLocalNotificationsPlugin();
  //   // var obj = await FlutterLocalNotificationsPlugin()
  //   //     .resolvePlatformSpecificImplementation<iosPlugin>();
  //
  //   iosPlugin!.deleteNotificationChannelGroup(channelId);
  //   return;
  // }
}

//----------------------------------------------- test enviroment

Future _printSourceDebug(MMessageFcm mFcm) async {
  if (EnvironmentConstant.isLive) {
    return;
  }

  if (mFcm.receivedStateTypeBackGround) {
    mFcm.title = mFcm.title + " {background}";
  }
  if (mFcm.receivedStateTypeForGround) {
    mFcm.title = mFcm.title + " {ForGround}";
  }
  if (mFcm.receivedStateTypeUserClickOnNotification) {
    mFcm.title = mFcm.title + " {MessageOpenApp}";
  }
}
