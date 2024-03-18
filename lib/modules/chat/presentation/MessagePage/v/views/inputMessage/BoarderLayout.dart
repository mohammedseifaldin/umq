import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/views/inputMessage/CameraAndAttachView.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/views/inputMessage/InputMessageView.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/views/inputMessage/TextFieldChat.dart';

//the layout that carry in whats app :
//      a- text message
//      b- button attach icon
//      c- button capture cameraOrFile

extension BoarderLayout on InputMessageState {
  Widget getContainerLayoutInput() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(top: 5, left: 5),
      width: getWidthDecorationBoarder(),
      decoration: getDecorationTextField(),
      child: _getContentBoarder(),
    );
  }

  Widget _getContentBoarder() {
    return Stack(
      children: [
        //frame height
        EmptyView.empty(
            getWidthDecorationBoarder(),
            InputMessageState.height_Frame -
                10 //why -10 ? it's margin of superview
            //     Colors.white
            ),

        // textField
        getTextFieldChat(),

        //button attach + camera
        Positioned(right: 0, child: getRowCameraAndAttach())
      ],
    );
  }

  double getWidthDecorationBoarder() {
    return DeviceTools.getWidth(context) - buttonSave_frame_widht;
  }
}
