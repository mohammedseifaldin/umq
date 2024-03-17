import 'package:firebase_messaging/firebase_messaging.dart';

class MMessageFcm {

  RemoteMessage messageRemote;

  MMessageFcm( this.messageRemote);

  //state of received
  bool receivedStateTypeForGround = false;
  bool receivedStateTypeBackGround = false;
  bool receivedStateTypeUserClickOnNotification = false;

  //type
  bool typeNotifyNotification = false;
  bool typeNotifyData = false;   // print notification  by data payload
  bool isHideNotification = false;   // no need to print notification, just need socket data to do action

  String title = "" ; //read title
  String body = ""  ;

  @override
  String toString() {
    return 'MMessageFcm{messageRemote: $messageRemote, stateTypeForGround: $receivedStateTypeForGround, stateTypeBackGround: $receivedStateTypeBackGround, stateTypeOnMessageOpenApp: $receivedStateTypeUserClickOnNotification, typeNotifyNotification: $typeNotifyNotification, typeNotifyData: $typeNotifyData, typeSocketData: $isHideNotification, title: $title, body: $body}';
  }
}