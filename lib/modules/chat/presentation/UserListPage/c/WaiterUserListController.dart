import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/modules/chat/presentation/UserListPage/c/ChatUserListResultController.dart';
import 'package:umq/modules/chat/presentation/UserListPage/v/ChatUserListPage.dart';
import 'package:umq/modules/chat/shared/toolsChat/singletone/socketWaiter/SocketWaiterSingleTone.dart';

extension WaiterUserListController on ChatUserListState {

  Future initWaiter() async {
    SocketWaiterSingleTone.instance().addWaiterChatUser(   (listUpdate, userPage) {

     Log.i( "initWaiter() - listUpdate: " + listUpdate.length.toString() );

      //remove old error
      errorMsg = null;

      //update list
      paginateState!.updateCurrentPage( userPage );
      setResultChatList(  listUpdate );

    });
  }


}