import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/chat/presentation/UserListPage/v/ChatUserListPage.dart';
import 'package:umq/modules/chat/presentation/UserListPage/v/views/ListViewUser/LastMessageView.dart';
import 'package:umq/modules/chat/data/model/MChatUser.dart';

import 'package:umq/modules/chat/shared/toolsChat/resource/ChatDrawable.dart';
import 'package:umq/modules/chat/shared/toolsChat/route/ChatRoute.dart';


import 'BadgeView.dart';

 double itemOfUserChatView_height = 50;

extension ItemOfUserChatView on ChatUserListState {


  Widget itemOfUserChatView(MChatUser mChatUser) {

    var cont =  Container( child: _contentChatUser( mChatUser),
      decoration: BoarderHelper.rounded(
        colorBackground: DSColor.cardview_background_color,
      ),
      padding: EdgeInsets.all( DSDimen.space_level_4 ),
      margin: EdgeInsets.only(
        left: DSDimen.space_level_2,
        right: DSDimen.space_level_2,
        top: DSDimen.space_level_3
      ),
    );

    return GestureDetector( child:  cont ,

      onTap: (){
        int userTargetId = mChatUser.user!.id!;
        ChatRouteGoTo.specificUser_openFromChatUserList(context, userTargetId);
      },
    );
  }


  Widget _contentChatUser(MChatUser mChatUser) {
    return Stack( children: [

      //size
      EmptyView.empty( DeviceTools.getWidth(context),  itemOfUserChatView_height ),

      //photo + name
      _photoIm(mChatUser),
      _nameTV(mChatUser),

      //last message
      Positioned(child:  lastMessageView( mChatUser.lastMessage, mChatUser.counterNotRead??0)  , bottom: 0,
        left: itemOfUserChatView_height  + DSDimen.space_level_3,),


      //badget
       _badgeView( mChatUser)



    ],);
  }

  Widget _badgeView(MChatUser mChatUser){
    if( mChatUser.lastMessage != null ) {
      return Positioned(child:  BadgeView( mChatUser.lastMessage! , mChatUser.counterNotRead??0),
        right: 0,
        // top: DSDimen.space_level_4,
      );
    } else {
      return EmptyView.zero();
    }
  }

  Widget _photoIm(MChatUser mChatUser) {

    //check not found
    String photoPrint = "";
    if( mChatUser.user != null ) {
      photoPrint =  mChatUser.user!.photo??"";
    }

    return ImageViewTemplate( context: context,
      widthNeeded: itemOfUserChatView_height - 10,
        heightNeeded: itemOfUserChatView_height - 10,
      radius_all: 10,
      // colorBackground: Colors.grey,
      assetAspectRatio: ChatDrawable.images( "person"),
      urlBackground:  photoPrint,
      boxFit_background: BoxFit.cover,
    );
  }



  Widget _nameTV(MChatUser mChatUser) {
    //check deleted user
    var namePrint = "Deleted User";
    if( mChatUser.user != null ) {
      namePrint = mChatUser.user!.name??"";
    }
    return TextTemplate.t(  namePrint,
      levelDS: LevelDS.l2,
      margin: EdgeInsets.only(left: itemOfUserChatView_height + DSDimen.space_level_3 )
    );
  }




}
