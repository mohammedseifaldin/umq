import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/ChatMessagePage.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/views/inputMessage/ButtonSaveView.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/views/inputMessage/CameraAndAttachView.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/views/inputMessage/InputMessageView.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/views/inputMessage/TextFieldChat.dart';
import 'package:umq/modules/chat/shared/toolsChat/resource/ChatColor.dart';

/**
 the layout that carry in whats app :
      a- text message
      b- button attach icon
      c- button capture cameraOrFile
 */
extension BoarderLayout on InputMessageState {


  Widget getContainerLayoutInput(){
    return Container(
      child: _getContentBoarder(),
      alignment: Alignment.centerLeft,
      //size
     margin: EdgeInsets.only(top: 5, left: 5 ),
      width:     getWidthDecorationBoarder(),
      //decoration
      decoration: getDecorationTextField(),
    );
  }


  Widget _getContentBoarder(){
    return Stack( children: [

      //frame height
      EmptyView.empty(
          getWidthDecorationBoarder(),
          InputMessageState.height_Frame - 10 //why -10 ? it's margin of superview
     //     Colors.white
      ),

      // textField
       getTextFieldChat(),

      //button attach + camera
      Positioned(child:  getRowCameraAndAttach(), right: 0 )
    ],);
  }


  double getWidthDecorationBoarder() {
    return  DeviceTools.getWidth(context ) - buttonSave_frame_widht;
  }


}