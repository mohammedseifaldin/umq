import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/chat/presentation/MessagePage/c/InputViewController/saveButton/ButtonSaveController.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/views/inputMessage/InputMessageView.dart';
import 'package:umq/modules/chat/shared/toolsChat/resource/ChatColor.dart';
import 'package:umq/modules/chat/shared/toolsChat/resource/ChatDrawable.dart';
import 'package:umq/tools/resourceProject/ColorProject.dart';

extension ButtonSaveView on InputMessageState {
  Widget getButtonSave() {
    var sizeCircle = 40.0;

    var cont = Container(
      width: sizeCircle,
      height: sizeCircle,
      alignment: Alignment.center,
      decoration: BoarderHelper.rounded(
          radiusSize: sizeCircle,
          colorLine: _getIconSaveBackgroundColor(),
          colorBackground: _getIconSaveBackgroundColor()),
      child: chooseTypeProgressOrButton(),
    );

    var paddingClick = Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
      child: cont,
    );

    //padding with click
    return GestureDetector(
      child: paddingClick,
      onTap: () async {
        await buttonSaveClick();
      },
    );
  }

  Widget chooseTypeProgressOrButton() {
    //case : progress
    if (prg_recorder) {
      return progressRecorderView();
    }

    //show button
    return ImageViewTemplate(
      context: context,
      widthNeeded: 25,
      heightNeeded: 25,
      padding: const EdgeInsets.all(10),
      onPressed: () async {
        await buttonSaveClick();
      },
      assetBackground: _getIconSaveByChooseType(),
    );
  }

  AssetImage _getIconSaveByChooseType() {
    // Log.i( "_getIconSaveByChooseType() - isSaveButtonType_record " + isSaveButtonType_record.toString() );
    //  Log.i( "_getIconSaveByChooseType() - isRecorderRun " + isRecorderRun.toString() );

    //type : recorder button
    if (isSaveButtonType_record) {
      //case : start/stop
      if (isRecorderRun) {
        return ChatDrawable.images("record_run");
      } else {
        return ChatDrawable.images("record");
      }
    }

    //type: message txt
    return ChatDrawable.images("send");
  }

  Color _getIconSaveBackgroundColor() {
    //is record on
    if (isSaveButtonType_record) {
      if (isRecorderRun) {
        return ChatColor.buttonSave_record_runing;
      }
    }

    //default
    return ChatColor.buttonSave_background;
  }

  Widget progressRecorderView() {
    Log.i("progressRecorderView() - start");
    var prg = CircularProgressIndicator(color: HexColor(ColorProject.red));

    return Container(
      alignment: Alignment.center,
      child: prg,
      // width: 25,
      //   height: 25,
      // padding: EdgeInsets.all( 10 ),
    );
  }
}
