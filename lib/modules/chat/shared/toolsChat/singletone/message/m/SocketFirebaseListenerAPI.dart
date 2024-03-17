//
//
// import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
//
// import '../../../dataCache/lastUpdate/DataLastUpdate.dart';
//
//
// typedef CallbackSocketFirebase = Function( bool status, String msg , int lastupdateTimestamp );
//
// class SocketFirebaseListenerAPI {
//
//   CallbackSocketFirebase? callbackSocket ;
//
//   Future getData(CallbackSocketFirebase callbackSocket) async {
//     this.callbackSocket = callbackSocket;
//
//     //check not login
//     if( isFirebaseLogin() ) {
//       _startFirebaseListener();
//     } else {
//       Log.i( "chat - SocketFirebaseListenerAPI - isFirebaseLogin() = (false) - stop!! ");
//     }
//
//   }
//
//   Future _startFirebaseListener() async{
//     FirebaseDatabase database = FirebaseDatabase.instance;
//
//     /**
//         https://scuba-6780c-default-rtdb.firebaseio.com/chat_app/socket/userIdxxxxx/lastupdate
//      */
//     String pathRef = "chat_app/socket/" + getFirebaseUserId() + "/lastupdate";
//     DatabaseReference ref = FirebaseDatabase.instance.ref( pathRef );
//     ref.onValue.listen((DatabaseEvent event) {
//       Log.i( "chat - _startFirebaseListener - event: " + event.toString() );
//       Object? data = event.snapshot.value;
//
//       if( data != null ) {
//         parseData( data);
//       } else {
//        callbackFailed("data is null");
//       }
//
//     }).onError((e) {
//       callbackFailed( e.toString());
//     });
//
//   }
//
//   //-------------------------------------------------------------------- tools firebase
//
//   String getFirebaseUserId()  {
//     User? userFirebase = FirebaseAuth.instance.currentUser;
//     return userFirebase!.uid;
//   }
//
//
//   bool isFirebaseLogin()  {
//     User? userFirebase = FirebaseAuth.instance.currentUser;
//     return userFirebase != null;
//   }
//
//
//   void parseData(Object data) {
//     ..
//     //parse
//     Log.i( "chat - parseData - data: " + data.toString() );
//     int lastTimeUpdate = data as int;
//     Log.i( "chat - parseData - lastTimeUpdate: " + lastTimeUpdate.toString() );
//
//     //save time last update
//     DataLastUpdate.setLastUpdateSocket( lastTimeUpdate);
//
//     //call back
//     callbackSuccess( lastTimeUpdate);
//   }
//
//   //----------------------------------------------------------------- call back
//
//   void callbackFailed(String msg ) {
//     if( callbackSocket != null ) {
//       callbackSocket!(false, msg , 0 );
//     }
//   }
//
//   void callbackSuccess(int lastTimeUpdate) {
//     if( callbackSocket != null ) {
//       callbackSocket!(true, "success", lastTimeUpdate );
//     }
//   }
//
//
// }
