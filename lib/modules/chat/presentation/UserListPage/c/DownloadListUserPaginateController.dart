import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/modules/chat/presentation/UserListPage/c/ChatUserListResultController.dart';
import 'package:umq/modules/chat/presentation/UserListPage/c/NavigateToSpecificUserController.dart';
import 'package:umq/modules/chat/presentation/UserListPage/v/ChatUserListPage.dart';
import 'package:umq/modules/chat/data/source/userChatList/ChatUserListAPI.dart';
import 'package:umq/modules/chat/data/response/userChatList/ResponseChatUserList.dart';
import 'package:umq/modules/chat/shared/toolsChat/dataCache/lastUpdate/DataLastUpdate.dart';
import 'package:umq/modules/chat/shared/toolsChat/singletone/message/NewMessageSingleTone.dart';
import 'package:umq/toolsUI/toast/ToastTools.dart';


extension DownloadListUserPaginateController on ChatUserListState {



  Future getUserPage(int pageNew)  async {

    //get time
    // int startTimestamp = await DataLastUpdate.getLastUpdateSocket();

    //progress
    if( paginateState != null ) paginateState!.progressStart();

    //api
    await new ChatUserListAPI().getPaginate( pageNew, (status, msg, response) {



      //check failed
      if( status == false ) {
        _caseFailedDownloadPage( pageNew, msg );
        return;
      }

      //remove old error
      errorMsg = null;

      //paginate
      _updatePaginate(pageNew, response );

      //set result
      setResultChatList( response.data!.data! );

      //navigate
      initNeedToNavigateToSpecificUser();

    });
  }

  void _caseFailedDownloadPage(int pageNew, String msg) {

    //not to print toast "in first chat"
    /**
     * when the page will already navigate avoid print toast ,
     * to avoid show toast at second page by wrong
     */
    if(  ToolsValidation.isValidInteger( widget.navigateToSpecificUserId )) {
      initNeedToNavigateToSpecificUser();
    } else {
      ToolsToast.i(context, msg);
    }


    //hide all user list and show error message
    setState( (){
      errorMsg = msg;
    });
  }

  void _updatePaginate(int pageNew, ResponseChatUserList response) {
    if( paginateState != null ){
      paginateState!.progressEnd_waitForNextScroll();
      paginateState!.updateCounterOfLaravel(
          currentPage: response.data!.currentPage!,
          totalRecord: response.data!.total!,
          currentRecord: response.data!.data!.length);
    }
  }


}