import 'package:flutter/material.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/views/listview/itemlist/ItemMessageView.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/views/listview/itemlist/MessageViewToolsUI.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/views/listview/itemlist/receiver/ReceiverHelperUI.dart';



extension ReceiverRecorderFormat on ItemMessageState {

  Widget formatRecorderReceiver() {
    var playIcon = getPlayIconRecorder();
    return containerReceiver( playIcon, recorderFrameWidth );
  }


}