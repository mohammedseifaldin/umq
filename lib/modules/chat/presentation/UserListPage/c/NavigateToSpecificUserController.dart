import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/modules/chat/presentation/UserListPage/v/ChatUserListPage.dart';
import 'package:umq/modules/chat/shared/toolsChat/route/ChatRoute.dart';
import 'package:umq/tools/cache/user_single_tone.dart';


extension NavigateToSpecificUserController on ChatUserListState {

  Future initNeedToNavigateToSpecificUser() async {

    //check not found
    if( widget.navigateToSpecificUserId == null ) return;
    Log.i( "initNeedToNavigateToSpecificUser() - navigateToSpecificUserId: " + widget.navigateToSpecificUserId.toString() );

    //check guest
    if( await UserSingleTone.instance().isGuest() ) {
      return;
    }

    //go to
    ChatRouteGoTo.specificUser_openFromChatUserList( context, widget.navigateToSpecificUserId! );

    //remove
    widget.navigateToSpecificUserId = null;
  }


}