import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';

import 'package:umq/modules/chat/data/source/lastUpdate/ChatSocketContinueAPI.dart';
import 'package:umq/modules/chat/presentation/UserListPage/v/ChatUserListPage.dart';

import 'package:umq/modules/chat/shared/toolsChat/singletone/socketContinue/SocketContinueController.dart';
import 'package:umq/modules/chat/shared/toolsChat/singletone/message/m/FcmSocketDownloadData.dart';
import 'package:umq/modules/chat/shared/toolsChat/singletone/socketWaiter/SocketWaiterSingleTone.dart';
import 'package:umq/tools/time/TimeTools.dart';

class SocketContinueDownloadData extends SocketContinueController {

  static Future apiSocketContinue() async {

    //get info
    int user_limit = FcmSocketDownloadData.calculateUserPageListLimit();

    // page scroll when call api
    int userPage = ChatUserListPage.pageScroll;

    //change status to progress
    SocketContinueController.statusProcessId = 1;

    //api
    ChatSocketContinueAPI().getData(user_limit: user_limit,
        message_greater_than_time: SocketContinueController.messageIdQueryGreaterThan,
        index_loop: SocketContinueController.counterDownloadCompleted,
        countryCode : SocketContinueController.countryCode??"",
        callBack: _callBack(userPage, SocketContinueController.timePreviousRun) );
  }


  static ChatChatSocketContinueAPICallBack _callBack (int userPage, int timeFireRequest ) {
    return ( status, msg, response  ){

      //change status to complete
      SocketContinueController.statusProcessId = 2;

      //log
      SocketContinueController.counterDownloadCompleted = SocketContinueController.counterDownloadCompleted +1;
      var counterNew =  SocketContinueController.counterDownloadCompleted.toString();
     // Log.i( "ChatChatSocketContinueAPICallBack - _callBack finished " +  counterNew );
     //  Log.i( "SocketContinueDownloadData - _callBack() - status: " +  status.toString()   );

      //check before update waitier
      if( status == false ) return;

      //now change greater query
      SocketContinueController.messageIdQueryGreaterThan = response.data!.next_socket_search_for_greater_than_id??0 ;

      Log.i( "SocketContinueDownloadData - _callBack() - counterNew: " +  counterNew  + " /messageIdQueryGreaterThan: " + SocketContinueController.messageIdQueryGreaterThan.toString() );

      //call socket waiter
      SocketWaiterSingleTone.instance().fireCallbackWaiterChatUserPage(response.data!.userUpdate!, userPage);
      SocketWaiterSingleTone.instance().fireCallbackWaiterChatMessagePage(response.data!.messageUpdate!);
      FcmSocketDownloadData.setLastMessageId(response.data!.messageUpdate!);

    };
  }


}