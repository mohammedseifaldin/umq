import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/modules/profile/data/model/m_user.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/ChatMessagePage.dart';

extension UserProfileController on ChatMessageState {

  Future updateUserProfile(MUser? userTargetSmall ) async {
  //  Log.i("updateUserProfile() - userTarget: " + userTarget.toString() );
    if( userTargetSmall == null ) return;

    //check already found before
    /**
     * avoid update profile already found
     */
    if( widget.userTargetSmall != null ) return;

    //check null
    if( stateToolbar == null ){
      Log.i("updateUserProfile() - stateToolbar == null - stop ");
      return;
    }

    //set value and change state
    widget.userTargetSmall = userTargetSmall;
    stateToolbar!.updateUserData(userTargetSmall);
  }


}