import 'package:umq/modules/chat/presentation/UserListPage/v/ChatUserListPage.dart';

@Deprecated( "Wait for version sql offline")
extension DialogDownloadLargeDataController on ChatUserListState {
//
//
// @Deprecated( "Wait for version sql offline")
//   Future initFirstTimeInstallApp() async {
//
//     //check first time
//     bool isFirstTime = await DataLastUpdate.getFirstTimeInstallApp();
//     if( isFirstTime  == false ) {
//       startDownloadFirstUserList();
//       return;
//     }
//
//     //progress start
//     _showProgressStartForDownloadUserList();
//
//     // download all users
//     downloadAllUsers();
//
//   }
//
//   //---------------------------------------------------------------- status of page
//
//   Future _showProgressStartForDownloadUserList() async {
//     // show dialog
//     setState(() {
//       isDialogSyncLargeDataShow = true;
//       dialogLargeData_total = 2;
//       dialogLargeData_progress = 1; //means still downloading user list data
//      // Log.i( "showProgressStartForDownloadUserList() - start  "  );
//     });
//   }
//
//
//   Future startDownloadFirstUserList() async {
//     Log.i( "startDownloadFirstUserList() - start  "  );
//
//     //
//     await loadDataFromSql( 1 );
//   }
//
//   //------------------------------------------------------------------- api
//
//   Future downloadAllUsers() async {
//
//     //progress
//     if( paginateState != null )paginateState!.progressStart();
//
//     //api
//     await new ChatUserListAPI().getAllData(callBack: ( status, msg, response){
//
//
//       //progress
//       if( paginateState != null )paginateState!.progressEnd_waitForNextScroll();
//
//       //check failed
//       if( status == false ) {
//         ToolsToast.i(context, msg);
//         return;
//       }
//
//       //set get before
//       DataLastUpdate.setFirstTimeInstallApp( true );
//
//       // save to sql
//       /**
//        * #abdo:
//        * //nextVersion: offline model
//        */
//
//       //set result
//       setResultChatList( response.data!.data! );
//
//
//     });
//
//   }


}