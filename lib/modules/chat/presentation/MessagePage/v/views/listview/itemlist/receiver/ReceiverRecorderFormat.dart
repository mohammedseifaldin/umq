import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/chat/presentation/MessagePage/c/itemList/ItemListRecorderController.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/views/listview/itemlist/ItemMessageView.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/views/listview/itemlist/MessageViewToolsUI.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/views/listview/itemlist/receiver/ReceiverHelperUI.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/views/listview/itemlist/sender/SenderHelperUI.dart';
import 'package:umq/modules/chat/shared/toolsChat/constant/ToolsEnumReadStatus.dart';
import 'package:umq/modules/chat/data/modelTools/ToolsMChatMessage.dart';
import 'package:umq/modules/chat/shared/toolsChat/resource/ChatColor.dart';
import 'package:umq/modules/chat/shared/toolsChat/resource/ChatDrawable.dart';



extension ReceiverRecorderFormat on ItemMessageState {

  Widget formatRecorderReceiver() {
    var playIcon = getPlayIconRecorder();
    return containerReceiver( playIcon, recorderFrameWidth );
  }


}