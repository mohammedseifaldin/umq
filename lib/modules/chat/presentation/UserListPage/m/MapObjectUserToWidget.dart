import 'package:flutter/material.dart';
import 'package:umq/modules/chat/presentation/UserListPage/v/ChatUserListPage.dart';
import 'package:umq/modules/chat/presentation/UserListPage/v/views/ListViewUser/ItemOfUserChatView.dart';
import 'package:umq/modules/chat/data/model/MChatUser.dart';

extension MapObjectUserToWidget on ChatUserListState {


  void  mapUserListObjectToWidget(List<MChatUser> listUserNew){
    //generate list widget
    List<Widget> listWidgetUpdated = [];
    for( int i = 0; i < listUserNew.length; i++ ) {
      MChatUser mChatUser = listUserNew[ i ];

      //check empty
      

      Widget w = itemOfUserChatView( mChatUser );
      listWidgetUpdated.add( w );

    }

    //replace
    listUserData = listUserNew;
    listUserWidget = listWidgetUpdated;
  }


}