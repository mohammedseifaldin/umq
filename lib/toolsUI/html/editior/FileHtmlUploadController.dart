import 'package:flutter/material.dart';
import 'package:umq/tools/network/BackendConstant.dart';
import 'package:umq/toolsUI/html/api/GenerateFileLaravelAPI.dart';
// import 'package:umq/backend/constant/BackendConstant.dart';
// import 'package:umq/tools/laravel/generate/GenerateFileLaravelAPI.dart';
import 'package:umq/toolsUI/toast/ToastTools.dart';

import 'HtmlEditiorPage.dart';

extension FileHtmlUploadController on HtmlEditorState {
  Future uploadHtmlData() async {
    //validate
    String htmlData = await controller.getText();
    if (htmlData.isEmpty) {
      ToolsToast.i(context, "missed field");
      return;
    }

    //progress
    setState(() {
      progressStatus = true;
    });

    //api
    await _networkGenerateFileHtmlAsUrl(htmlData);

    // widget.callback(value);
    // Navigator.pop(context);
  }

  Future _networkGenerateFileHtmlAsUrl(String htmlData) async {
    String urlApiLink = "${BackendConstant.baseUrlv2}/file-generate";

    //listener
    await GenerateFileLaravelAPI().getDataByPostContent(
      urlAPILink: urlApiLink,
      content: htmlData,
      file_name: widget.uniqueName,
      callBack: (status, msg, responseGenerateFile) {
        //progress
        setState(() {
          progressStatus = false;
        });

        //check failed
        if (status == false) {
          ToolsToast.i(context, msg);
          return;
        }

        //success
        String fullPathUrlGenerated = responseGenerateFile.fullPath!;
        _successGetPathUrl(fullPathUrlGenerated);
      },
    );
  }

  void _successGetPathUrl(String fullPathUrlGenerated) {
    widget.callback(fullPathUrlGenerated);
    Navigator.pop(context);
  }
}
