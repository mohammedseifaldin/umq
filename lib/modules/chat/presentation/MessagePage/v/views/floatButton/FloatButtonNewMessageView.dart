import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/chat/presentation/MessagePage/c/FloatButtonNewMessageController.dart';
import 'package:umq/modules/chat/presentation/MessagePage/c/ScrollMessageController.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/ChatMessagePage.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/views/inputMessage/InputMessageView.dart';
import 'package:umq/modules/chat/shared/toolsChat/resource/ChatColor.dart';
import 'package:umq/modules/chat/shared/toolsChat/resource/ChatDrawable.dart';
import 'package:umq/tools/audio/AudioSingleTone.dart';

extension FloatButtonNewMessageView on ChatMessageState {

  Widget getFloatButtonNewMessage() {
    //Log.i( "getFloatButtonNewMessage() - floatButtonStatus: " + floatButtonStatus.toString() );
    if( floatButtonStatus == false  ) {
      return EmptyView.zero();
    }

    // button
    var bt = _getButtonFloat();

    //margin
    return Container( child:  bt ,
      alignment: Alignment.topRight,
      // color: Colors.green,
      margin: EdgeInsets.only(
        right: DSDimen.space_level_2,
          bottom:    DSDimen.space_level_2 + InputMessageState.height_Frame
      ),
    );
  }


  Widget _getButtonFloat(){
    var image =  ImageViewTemplate(context: context,
        assetAspectRatio: ChatDrawable.images( "arrow_double_down") ,
        onPressed: () async {

          await setHideFloatButtonNow();
          await focusNowBottomScreenWithAnimate();


        },
        widthNeeded: 30,
        heightNeeded: 30);


    var ct = Container(
        child: image,
        alignment: Alignment.center,
        // color: ChatColor.floatButton_background,
        width: 50,
        height: 50,
        // padding: EdgeInsets.all(5 ), //boarder width
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ChatColor.floatButton_background,

        )

    );

    return ct;
  }



}