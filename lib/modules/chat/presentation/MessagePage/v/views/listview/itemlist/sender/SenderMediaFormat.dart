import 'package:flutter/material.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/views/listview/itemlist/ItemMessageView.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/views/listview/itemlist/MessageViewToolsUI.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/views/listview/itemlist/sender/SenderHelperUI.dart';

extension SenderMediaFormat on ItemMessageState {

  Widget formatImageSender() {
    return containerSender( imageMessageIm() , imageMediaSize  );
  }

}