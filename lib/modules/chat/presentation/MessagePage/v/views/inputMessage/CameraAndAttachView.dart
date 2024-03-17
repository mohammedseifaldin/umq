import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/chat/presentation/MessagePage/c/InputViewController/cameraOrFile/ChatFileInputController.dart';
import 'package:umq/modules/chat/presentation/MessagePage/c/InputViewController/cameraOrFile/ChatImageInputController.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/ChatMessagePage.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/views/inputMessage/InputGenericUI.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/views/inputMessage/InputMessageView.dart';
import 'package:umq/modules/chat/shared/toolsChat/resource/ChatColor.dart';
import 'package:umq/modules/chat/shared/toolsChat/resource/ChatDrawable.dart';



extension CameraAndAttachView on InputMessageState {


  Widget getRowCameraAndAttach(){
    //check empty
    if( frame_width_cameraAndAttachView == 0 ) {
      return EmptyView.zero();
    }

    //show
    return RowTemplate.wrapChildren( [
      cameraIm(),
      attachIm(),

      //padding
      EmptyView.empty( DSDimen.textfield_auto_padding, DSDimen.textfield_auto_padding)
    ]);
  }


  Widget cameraIm() {
    //check progress avoid upload two files
    if( prg_capture ) {
      return progressView();
    }

    //show
    var im = ImageViewTemplate(context: context,
        padding: EdgeInsets.all( 5 ),
        widthNeeded: 35,
        heightNeeded: 35,
        assetAspectRatio: ChatDrawable.images( "camera"),
      onPressed: () async {
        await captureClick();
      },
    );

    return im;
  }


  Widget attachIm() {
    //check progress avoid upload two files
    if( prg_attachFile ) {
      return progressView();
    }

    //show
    var im = ImageViewTemplate(context: context,
      padding: EdgeInsets.all( 5 ),
      widthNeeded: 28,
      heightNeeded: 28,
      assetAspectRatio: ChatDrawable.images( "attach"),
      onPressed: () async {
        await attachClick();
      },
    );

    return im;
  }


}