import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/views/listview/itemlist/ItemMessageView.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/views/listview/itemlist/MessageViewToolsUI.dart';
import 'package:umq/modules/chat/data/model/MChatMessage.dart';

import 'package:umq/modules/chat/shared/toolsChat/resource/ChatColor.dart';
import 'package:umq/tools/constant/EnvironmentConstant.dart';
import 'package:umq/tools/network/ToolsAPI.dart';
import 'package:umq/toolsUI/textField/TextFieldWidthGetter.dart';

import 'SenderHelperUI.dart';

extension SenderTextFormat on ItemMessageState {

  Widget formatTextViewSender( ) {
    //test
    String txt = mChatMessage.text??"";
    if( EnvironmentConstant.isTest ) {
      txt = "(" + mChatMessage.id.toString() + ") " + txt ;
    }

    //check deleted
    if( ToolsAPI.isTrue( mChatMessage.deleted ) ) {
      txt = "* deleted *";
    }

    //msg
    var txt_message = TextTemplate.t( txt ,
        levelDS: LevelDS.l3,
        color: ChatColor.msg_text_color,
        textAlign: TextAlign.end
    );

    //calculate width frame
    double widthContent = TextWidthGetter.get(
        context: parentState.context,
        txt: txt,
        dimenFont: DSDimen.text_level_3
    );

   return containerSender( txt_message, widthContent   );

  }



}