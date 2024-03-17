import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/views/listview/itemlist/ItemMessageView.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/views/listview/itemlist/MessageViewToolsUI.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/views/listview/itemlist/sender/SenderHelperUI.dart';
import 'package:umq/tools/resourceProject/DrawableProject.dart';

extension SenderMediaFormat on ItemMessageState {

  Widget formatImageSender() {
    return containerSender( imageMessageIm() , imageMediaSize  );
  }

}