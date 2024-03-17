
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/chat/data/model/MChatMessage.dart';

import 'package:umq/modules/chat/shared/toolsChat/resource/ChatDrawable.dart';
import 'package:umq/tools/values/ToolsValue.dart';

import '../../ChatUserListPage.dart';
import 'ItemOfUserChatView.dart';


extension LastMessageView on ChatUserListState {


  Widget lastMessageView(MChatMessage? lastMessage, int counterNotReaded ) {

    //check have message
    if(  lastMessage == null  ) {
      return EmptyView.empty( 10, 40);
    }

    return Stack( children: [

      //size
      EmptyView.colored(DeviceTools.getWidth(context),
          itemOfUserChatView_height,
       Colors.transparent
      ),


        //content
        Positioned(child: _chooseTypeMessageContent( lastMessage, counterNotReaded),
        bottom: 0,)


    ]);
    //return
  }


  //----------------------------------------------------------  type chooser


  Widget _chooseTypeMessageContent(MChatMessage mMessage, int counterNotReaded) {
    //check type video
    if(  ToolsValue.isValid( mMessage.video ) ) {
      return _typeMedia( mMessage, "video");
    }

    //check type image
    if(  ToolsValue.isValid( mMessage.image ) ) {
      return _typeMedia( mMessage, "camera");
    }

    //check type recorder
    if(  ToolsValue.isValid( mMessage.recorder ) ) {
      return _typeRecorder( mMessage, "recorder");
    }

    //default message text
    return _typeText(mMessage);
  }

  //----------------------------------------------------------  type : media

  Widget _typeMedia(MChatMessage mMessage, String assetName) {

    AssetImage assetObj = ChatDrawable.images( assetName); //example: "video" or camera or recorder

    var img = ImageViewTemplate( context: context,
      widthNeeded: 10 ,
      heightNeeded: 10,
      assetBackground: assetObj,);


    return RowTemplate.wrapChildren(  [
      img,

      TextTemplate.t( assetName,
          margin: EdgeInsets.only(left: DSDimen.space_level_3 ),
          levelDS: LevelDS.l3)
    ],);
  }


  Widget _typeRecorder( MChatMessage mChatMessage, String assetName) {
    AssetImage assetObj = ChatDrawable.images( assetName); //example: "video" or camera or recorder

    var img = ImageViewTemplate( context: context,
      widthNeeded: 10 ,
      heightNeeded: 13.5,
      assetBackground: assetObj,);


    return RowTemplate.wrapChildren(  [
      img,

      TextTemplate.t( assetName,
          margin: EdgeInsets.only(left: DSDimen.space_level_3 ),
          levelDS: LevelDS.l3)
    ],);
  }

  //---------------------------------------------------------- type : text

  Widget _typeText(MChatMessage mMessage) {
    return  TextTemplate.t( mMessage.text,
        levelDS: LevelDS.l3 );
  }


}