
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/modules/chat/data/model/MChatUser.dart';


import '../../../../data/model/MChatMessage.dart';

typedef SocketWaiterCallbackChatMessage = Function( List<MChatMessage> listUpdate );
typedef SocketWaiterCallbackChatUser = Function( List<MChatUser> listUpdate , int userPage );


/**
  Documentation:

    - function of this class to waiting any change in socket


      a- case chat message: wait to socket change, then return back to all waitier message
      b- case chat user: wait to socket change, then return back to all waitier user
 */
class SocketWaiterSingleTone {


  //---------------------------------------------------------------------------- public variable

  static SocketWaiterCallbackChatUser? waiterChatUser;
  static SocketWaiterCallbackChatMessage? waiterChatMessage  ;


  //---------------------------------------------------------------------- single tone

  SocketWaiterSingleTone._();

  //2- make one time sync
  static bool _isSync = false;

  //3- return instance
  static SocketWaiterSingleTone instance(){
    if( _isSync == false ) {
      _isSync = true;
      _startSingletoneInitlize();
    }
    return SocketWaiterSingleTone._();
  }


  static _startSingletoneInitlize() {
    waiterChatMessage = null ;
    waiterChatUser = null ;
  }

  //--------------------------------------------------------------- public : chat user

  void addWaiterChatUser( SocketWaiterCallbackChatUser callback ) {
    waiterChatUser  = callback;
  }


  void fireCallbackWaiterChatUserPage(List<MChatUser> listUpdate , int userPage ){
    if(waiterChatUser == null ) return;
    waiterChatUser!( listUpdate, userPage);
  }

  //--------------------------------------------------------------- public : chat message

  void addWaiterChatMessage(  SocketWaiterCallbackChatMessage callback ) {
    waiterChatMessage = callback;
  }


  Future fireCallbackWaiterChatMessagePage(List<MChatMessage> listUpdate  ) async {
    if(waiterChatMessage == null ) return;

 //
    waiterChatMessage!( listUpdate);
  }





}