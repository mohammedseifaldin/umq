import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/toolsUI/html/editior/HtmlEditiorPage.dart';
import 'package:umq/toolsUI/toast/ToastTools.dart';


extension UrlContentEditior on HtmlEditorState {


  Future setupUrlContent() async {
    //check not need
    if(widget.edit_url_content == null ) return;

    //progress
    setState(() {
      progressStatus = true;
    });

    //api get
    _apiDownloadContentOfUrl();
  }


  Future _apiDownloadContentOfUrl() async {
    NetworkManagerHttp(
       widget.edit_url_content!,
      type: NetworkTypeHttp.get,
      callback: (status, msg, dataStr ) {

         if( status == false ) {
           Log.i( "UrlContentEditior - _apiDownloadContentOfUrl() - status == false - msg: $msg" );
           //progress
           setState(() {
             progressStatus = false;
           });
           ToolsToast.i(context, "Failed To Download Old Data Content. Refresh THe Page");
           return;
         }


         //progress
         setState(() {
           Log.i( "UrlContentEditior - _apiDownloadContentOfUrl() - success download data: " + dataStr);
           progressStatus = false;
           widget.edit_dataHtml_content = dataStr.toString();
           hideHtmlEditorUntilDownloadUrlContent = false; // now show again
         });



      }
    );
  }


}