import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';

import 'package:umq/modules/chat/data/source/lastUpdate/ChatLastUpdateByFcmSocketAPI.dart';

import 'package:umq/modules/chat/data/model/MChatMessage.dart';
import 'package:umq/modules/chat/data/source/message/ChatMessageStatusAPI.dart';
import 'package:umq/modules/chat/presentation/UserListPage/c/paginate/ChatScrollManager.dart';
import 'package:umq/modules/chat/presentation/UserListPage/v/ChatUserListPage.dart';
import 'package:umq/modules/chat/shared/toolsChat/singletone/lifeCycle/LifeCycleSingletone.dart';
import 'package:umq/modules/chat/shared/toolsChat/singletone/message/NewMessageSingleTone.dart';
import 'package:umq/modules/chat/shared/toolsChat/singletone/socketWaiter/SocketWaiterSingleTone.dart';

extension FcmSocketDownloadData on NewMessageSingleTone {

  //---------------------------------------------------------------------- api status message received

  void updateMessageStatusReceived(String messageId ) async {
    //api
    ChatMessageStatusAPI().received(messageId: messageId,
        callBack:  (  msg, status, response ){


    });
  }

  //---------------------------------------------------------------------- api get last update

  void getDataAfterSenderIdByFCM(int sender_id) async {
    // int message_target_userid = ChatMessagePage.targetId;
    int message_greater_than_id = NewMessageSingleTone.lastMessageIdDownload;

    // page scroll when call api
    int userPage = ChatUserListPage.pageScroll;

    // calculate user_limit
    int user_limit = calculateUserPageListLimit();

    //api
    ChatLastUpdateByFcmSocketAPI().getData(user_limit: user_limit,
        fcm_sender_id: sender_id,
        message_greater_than_id: message_greater_than_id,
        callBack: _callBack( userPage ));
  }


  ChatLastUpdateAPICallBack _callBack (int userPage) {
    return ( status, msg, response  ){
      if( status == false ) return;

      //call socket waiter
      SocketWaiterSingleTone.instance().fireCallbackWaiterChatUserPage(response.data!.userUpdate!, userPage);
      SocketWaiterSingleTone.instance().fireCallbackWaiterChatMessagePage(response.data!.messageUpdate!);

      setLastMessageId(response.data!.messageUpdate!);

    };
  }


  static void setLastMessageId(List<MChatMessage> list ) {

    if( list.length == 0 ) return;
    MChatMessage first = list[0];
    NewMessageSingleTone.lastMessageIdDownload = first.id!;
  //  Log.i( "setLastMessageId() - id: " + first.id!.toString() );
  }

  /**
   *  how many users you need to download
      a- case page user list still at page "1" :
      now update the list call same api of get user list paginate 1

      b- case page user list still in scroll to pageinate page 2 :
      Now get data from page 1 to page 2 , just make paginator = 2 * 30 => 60
   */
  static int calculateUserPageListLimit() {

    //case page user list live
    bool isPageUserListOnResume = LifeCycleSingletone.instance().getChatListPage();
    if( isPageUserListOnResume ) {
      int limit = ChatUserListPage.pageScroll * ChatPaginateConstant.paginator;
      return limit;
    }

    //case default
    return ChatPaginateConstant.paginator;
  }


}