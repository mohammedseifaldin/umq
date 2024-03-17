import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


    void printRemoteMessage(RemoteMessage messageRemote ) {

    //messageRemote.notification
    if( messageRemote.notification != null ) {
      Log.i( "fcm - print() - title: " + messageRemote.notification!.title.toString() );
      Log.i( "fcm - print() - body: " + messageRemote.notification!.body.toString() );
    }

    //print data
    Log.i( "fcm - print() - data: " + messageRemote.data.toString() );

    //print general info
    Log.i( "fcm - print() - hashCode: " + messageRemote.hashCode.toString() );
    Log.i( "fcm - print() - messageId: " + messageRemote.messageId.toString() );
    Log.i( "fcm - print() - senderId: " + messageRemote.senderId.toString() );
    Log.i( "fcm - print() - threadId: " + messageRemote.threadId.toString() );
    Log.i( "fcm - print() - ttl: " + messageRemote.ttl.toString() );
    Log.i( "fcm - print() - sentTime: " + messageRemote.sentTime.toString() );
    Log.i( "fcm - print() - collapseKey: " + messageRemote.collapseKey.toString() );
  }
