import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/modules/chat/presentation/UserListPage/m/MapObjectUserToWidget.dart';
import 'package:umq/modules/chat/presentation/UserListPage/v/ChatUserListPage.dart';
import 'package:umq/modules/chat/data/model/MChatUser.dart';

extension ChatUserListResultController on ChatUserListState {

  Future setResultChatList(List<MChatUser> list ) async {


    //check life
    if( mounted == false )  {
      Log.i( "chat - ChatUserListResultController - setResultChatList() - mounted == false - stop !");
      return;
    }
  //  Log.i( "chat - ChatUserListResultController - list " + list.length.toString() );

    mapUserListObjectToWidget(list);

    _updateUIWithResult();

  }

  Future _updateUIWithResult() async {

    //
    setState((){
    });
  }


}