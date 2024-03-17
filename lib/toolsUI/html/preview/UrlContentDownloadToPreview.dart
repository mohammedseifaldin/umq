import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/toolsUI/toast/ToastTools.dart';

import 'HtmlPreviewWidget.dart';

extension UrlContentDownloadToPreview on HtmlPreviewState {



  Future setupUrlContent() async {
    Log.i( "setupUrlContent() - widget.downloadLink: " + widget.downloadLink.toString() );
    //check not need
    if( ToolsValidation.isEmpty( widget.downloadLink)   ) return;

    //progress
    setState(() {
      progressStatus = true;
    });

    //api get
    _apiDownloadContentOfUrl();
  }


  Future _apiDownloadContentOfUrl() async {
    Map<String, String> body = Map();
    body["test"] = "show html";
    NetworkManagerHttp(
        widget.downloadLink!,
        type: NetworkTypeHttp.post,
        body: body,
        callback: (status, msg, dataStr ) {
          Log.i( "_apiDownloadContentOfUrl() - status == false - msg: $msg" );

          if( status == false ) {
            Log.i( "_apiDownloadContentOfUrl() - status == false - msg: $msg" );
            //progress
            setState(() {
              progressStatus = false;
            });
            ToolsToast.i(context, "Failed To Download Data Content, Refresh The Page");
            Navigator.pop(context);
            return;
          }


          //progress
          setState(() {
            // Log.i( "_apiDownloadContentOfUrl() - success download data: " + dataStr);
            Log.i( "_apiDownloadContentOfUrl() - success download  " );
            progressStatus = false;
             htmlData = dataStr.toString();
            // hideHtmlEditorUntilDownloadUrlContent = false; // now show again
          });



        }
    );
  }



}