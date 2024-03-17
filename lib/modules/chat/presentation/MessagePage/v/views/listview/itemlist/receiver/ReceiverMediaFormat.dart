import 'package:flutter/material.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/views/listview/itemlist/ItemMessageView.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/views/listview/itemlist/MessageViewToolsUI.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/views/listview/itemlist/receiver/ReceiverHelperUI.dart';


extension ReceiverMediaFormat on ItemMessageState {

  Widget formatImageReceiver() {
    return containerReceiver( imageMessageIm()  , imageMediaSize );
  }

}