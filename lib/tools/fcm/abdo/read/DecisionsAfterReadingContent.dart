import 'dart:async';

import 'package:clear_all_notifications/clear_all_notifications.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';

import '../click_on_notification/SetupUserClickNotification.dart';
import '../general/m/MFcm.dart';
import '../pusher/PushNotification.dart';
import '../socketData/SocketDataFcmListener.dart';

    Future chooseWhatToDoPushOrEventSocketOnly (MMessageFcm mFcm ) async {

    //ios
    bool isIos = DeviceTools.isIOS();
    if(   isIos ) {
      await _whatToDo_ios( mFcm);
      return;
    }

    //android
    if( DeviceTools.isAndroid() ) {
      await _whatToDo_android( mFcm );
      return;
    }

  }


     Future _whatToDo_android(MMessageFcm mFcm) async {
    //push notify
    if( mFcm.isHideNotification == false ) {
      await  pushByLocalNotification( mFcm );
    }

    //socket event
    await  eventData(mFcm);
  }


    Future _whatToDo_ios(MMessageFcm mFcm) async {


    if( mFcm.isHideNotification == false ) {
      Log.i( "_whatToDo_ios() - _iosSetupNotification");
      await _iosSetupNotification( mFcm );

    } else {
      Log.i( "_whatToDo_ios() - eventData only");

      //clear notification
      await initClearNotificationsState();

      //socket event
      await eventData(mFcm);
    }
  }

     Future _iosSetupNotification(MMessageFcm mFcm) async {
    //check type "open by click on notification  " at ios
    /**
     * this case when click on notification  , need to navigate
     */
    if( mFcm.receivedStateTypeUserClickOnNotification  ) {
      //navigate
       setupClickNotificationOnForegroundIOS(  mFcm );

      //socket event
      await  eventData(mFcm);
      return;
    }

    _pushNotificationIOS(mFcm);

  }

/**
 * push already done automatically,
 * no need to push local notofication like android device
 */
  Future _pushNotificationIOS(MMessageFcm mFcm ) async {

  }


  /**
      //wait for show notification
   */
    Future<void> initClearNotificationsState() async {
    Log.i( "initClearNotificationsState() - start");

    Timer(Duration(milliseconds: 8000 ), ()  {

      ClearAllNotifications.clear();
      Log.i( "initClearNotificationsState() - done 8000 ");

    });
  }

