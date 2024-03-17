import 'package:flutter/material.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/views/inputMessage/InputMessageView.dart';
import 'package:umq/modules/chat/shared/toolsChat/resource/ChatColor.dart';

extension InputGenericUi on InputMessageState {


  Widget progressView() {

    double size = 25;
    var prg = CircularProgressIndicator( color: ChatColor.buttonSave_background);

    //container
    var ct = Container(
      width: size,
      height: size,
      child: prg,
    );
    return ct;
  }

}