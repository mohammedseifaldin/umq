// import 'package:easy_web_view/easy_web_view.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:umq/toolsUI/html/preview/UrlContentDownloadToPreview.dart';

// import 'package:flutter_super_html_viewer/flutter_super_html_viewer.dart';

// double htmpPreviewHeight = 2500;

class HtmlPreviewWidget extends StatefulWidget {
  String? htmlData;
  String? downloadLink; //first download link to previouew

  HtmlPreviewWidget({super.key, this.htmlData, this.downloadLink});

  @override
  HtmlPreviewState createState() => HtmlPreviewState(htmlData);
}

class HtmlPreviewState extends State<HtmlPreviewWidget> {
  var progressStatus = false;
  String? htmlData;

  HtmlPreviewState(this.htmlData);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setupUrlContent();
    });
  }

  @override
  Widget build(BuildContext context) {
    var isValidHtml = ToolsValidation.isValid(htmlData);
    Log.i("HtmlPreviewState - isValidHtml: $isValidHtml");
    if (isValidHtml) {
      return typeShowContentHtml(htmlData ?? "");
    }

    if (progressStatus) {
      return typeProgressDownloadData();
    }

    // if(widget.downloadLink != null ) {
    //   return typeShowContentHtml(widget.downloadLink??"");
    // }

    return TextFastor("choose one downloadLink|htmlData");
  }

  Widget typeShowContentHtml(String content) {
    return HtmlWidget(
      content,
      onErrorBuilder: (context, element, error) =>
          Text('$element error: $error'),
      onLoadingBuilder: (context, element, loadingProgress) =>
          const CircularProgressIndicator(),
      renderMode: RenderMode.column,

      //text color
      textStyle: TextStyle(
          fontSize: DSDimen.text_level_1,
          fontFamily: DSFont.h1,
          color: Colors.black,
          decoration: TextDecoration.none),
      customStylesBuilder: (element) {
        return {'color': 'black'};
      },
    );
  }

  Widget typeProgressDownloadData() {
    var prg = ProgressSpinkit.get();
    return Container(
      margin: const EdgeInsets.all(40),
      child: prg,
    );
  }
}

/**
 * import 'package:flutter_super_html_viewer/flutter_super_html_viewer.dart';
    return HtmlContentViewer(
    htmlContent: widget.htmlData,
    initialContentHeight: DeviceTools.getWidth(context), //MediaQuery.of(context).size.height,
    initialContentWidth: htmpPreviewHeight,
    );
 */