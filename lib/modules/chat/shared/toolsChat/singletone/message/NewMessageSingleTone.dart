import 'dart:core';

import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';

import 'package:umq/modules/chat/shared/toolsChat/singletone/socketContinue/SocketContinueController.dart';

import 'package:umq/modules/chat/shared/toolsChat/singletone/message/m/FcmSocketDownloadData.dart';

class NewMessageSingleTone {
  static int lastMessageIdDownload = 0; //the last message id downloaded

  //---------------------------------------------------------------------- single tone

  NewMessageSingleTone._();

  //2- make one time sync
  static bool _isSync = false;

  //3- return instance
  static NewMessageSingleTone instance() {
    if (_isSync == false) {
      _isSync = true;
    }
    return NewMessageSingleTone._();
  }

  //------------------------------------------------------------------- socket controller

  void startSocketMessageAndDownloadFirstPageData() {
    SocketContinueController().start();
  }

  void stopSocket() {
    SocketContinueController().stop();
  }

  //--------------------------------------------------------------------- add update manuel

  void fcmSocketHappened(String senderId, String messageId) {
    //to int
    // int  senderId = int.parse( senderId);
    Log.i("chat - fcmSocketHappened() - messageId: $messageId");

    //api update the list
    /** //Deprecated "not need" there is another socket
     * not need to use fcm socket
        getDataAfterSenderIdByFCM( sender_id);
     */

    //api received notificationAdmin

    updateMessageStatusReceived(messageId);
  }
}
