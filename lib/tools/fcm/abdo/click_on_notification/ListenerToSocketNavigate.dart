

import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';


import '../FCMRegister.dart';


typedef ListenerSelectNotificationCallBack = Function(   bool isSocketFound, String? payload);


class  ListenerToSocketNavigate   {

  //----------------------------------------------------------------------- variable

  static ListenerSelectNotificationCallBack? callback;

  /**
   * this method call from "HOme page only" not to call from "Splash Page"
   *  due to socket in background come after wait 2-10 second
   */
  static Future homePageListenerToFcmSocket(ListenerSelectNotificationCallBack callback ) async {
    Log.i( "fcm - homePageListenerToFcmSocket()  "   );
    ListenerToSocketNavigate.callback = callback;

    _validateSocketBackground();
  }


  //---------------------------------------------------------------------- validate

  static void _validateSocketBackground( ) {

    //check empty
    if( notificationPayloadStatic == null ) {
      _callBackReturnFailed();
      return;
    }

    //print toast
    _printToastValidation();

    //call back
    _setToCallBackSuccess();
  }



  //----------------------------------------------------------------- call back succss

  static void _setToCallBackSuccess(){
    //call back
    if( callback == null )return;


    //success
    callback!( true ,   notificationPayloadStatic  );
  }

  //--------------------------------------------------- call back failed

  static Future _callBackReturnFailed() async {
    if( callback != null ){
      callback!(false, null );
    }
  }

  //----------------------------------------------------------------- test mode

  /**
   * for testing only
   */
  static void _printToastValidation() {
    /**
        //toast
        BuildContext? contextFastor = FastorStateManagement.instance().getCurrentContext();
        if( contextFastor != null ) {
        ToolsToast.i( contextFastor,   FCMRegister.payload! );
        }

     */
  }


}

