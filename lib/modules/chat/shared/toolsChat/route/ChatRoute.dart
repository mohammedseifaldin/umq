import 'package:flutter/material.dart';
import 'package:need_resume/need_resume.dart';

import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/modules/chat/data/model/MChatUser.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/ChatMessagePage.dart';
import 'package:umq/modules/chat/presentation/UserListPage/v/ChatUserListPage.dart';
import 'package:umq/toolsUI/ImageFullScreen/ImageFullScreen.dart';

class ChatRouteGoTo {

  static void userList_push(BuildContext context ) {
    var w = ChatUserListPage( );
    NavigationTools.push( context,  w );
  }

  static void userList_pushAndRemove(BuildContext context ) {
    var w = ChatUserListPage( );
    NavigationTools.pushAndRemoveUntil( context,  w );
  }


  /**
   * when from outside list, need first to open main chat page
   *  to start socket and init listeners,
   *   after than will navigate to specific user
   */
  static void specificUser_openFromOutside(BuildContext context, int userTargetId) {
    var w = ChatUserListPage(navigateToSpecificUserId:  userTargetId );
    NavigationTools.push( context,  w );
  }

  static void specificUser_openFromOutside_resume(BuildContext context, ResumableState resume, int userTargetId) {
    var w = ChatUserListPage(navigateToSpecificUserId:  userTargetId );
    NavigationTools.pushResume( context,  w, resume );
  }



  static void specificUser_openFromChatUserList(BuildContext context, int userTargetId) {
    var w = ChatMessagePage(targetId:  userTargetId, isTypeGroup:  false   );
    NavigationTools.push( context,  w );
  }


  static void profileUser(BuildContext context, MChatUser? mChatUser) {
    if( mChatUser == null ) return ;
    if( mChatUser.user == null ) return ;
    String photo = mChatUser.user!.photo!;

    fullScreenImage( context, photo );
  }

  //--------------------------------------------------------------------- tools

  static void fullScreenImage(BuildContext context, String imageUrl) {
    var w = ImageFullScreen(imageUrl: imageUrl );
    NavigationTools.push( context,  w );
  }



}