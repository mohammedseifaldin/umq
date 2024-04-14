import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../shared/ToolsPayment.dart';

typedef WebviewPaymentUrlChange = Function(String urlChangeTo);

class WebviewPaymentPage extends StatefulWidget {
  final String url;
  final WebviewPaymentUrlChange urlChange;

  const WebviewPaymentPage({
    super.key,
    required this.url,
    required this.urlChange,
  });

  @override
  WebviewPaymentState createState() => WebviewPaymentState();
}

class WebviewPaymentState extends State<WebviewPaymentPage> {
  int progress = 0;

  WebviewPaymentState();

  //------------------------------------------------------------------- build

  @override
  Widget build(BuildContext context) {
    var stack = Stack(children: [
      //all screen size
      Placeholder(
          strokeWidth: 0,
          color: Colors.transparent,
          fallbackWidth: ToolsPayment.getWidth(context, ""),
          fallbackHeight: ToolsPayment.getHeight(context, "")),

      //webview
      inAppWebWidgetCustom(),

      //progress
      Align(alignment: Alignment.topLeft, child: progressViewLinear())
    ]);

    var cont = Container(
      color: Colors.white,
      child: stack,
    );
    return Scaffold(
      body: SafeArea(child: cont),
    );
  }

  //--------------------------------------------------------------- webview widget

  Widget inAppWebWidgetCustom() {
    URLRequest uri = URLRequest(url: Uri.parse(widget.url));
    Log.i("InAppWebWidgetCustom() - url: ${widget.url}");

    return InAppWebView(
      initialUrlRequest: uri,
      onProgressChanged: (InAppWebViewController controller, int progress) {
        this.progress = progress;

        //check
        if (this.progress == 100) {
          Log.i(
              "InAppWebWidgetCustom() - onProgressChanged - progress: $progress");
          progressStatus = false;
          setState(() {});
        }
      },
      onLoadStart: (controller, url) {
        Log.i("InAppWebWidgetCustom() - url: ${widget.url}");
        widget.urlChange(url.toString());
      },
      onLoadHttpError: (InAppWebViewController controller, Uri? url,
          int statusCode, String description) {
        Log.i(
            "InAppWebWidgetCustom() - onLoadHttpError - statusCode: $statusCode");
        Log.i(
            "InAppWebWidgetCustom() - onLoadHttpError - description: $description");
      },
      onLoadError: (InAppWebViewController controller, Uri? url, int code,
          String message) {
        Log.i("InAppWebWidgetCustom() - onLoadError - code: $code");
        Log.i("InAppWebWidgetCustom() - onLoadError - message: $message");
      },
    );
  }

  //-------------------------------------------------------------- progress

  var progressStatus = true;

  Widget progressViewLinear() {
    if (progressStatus) {
      return LinearProgressIndicator(
          value: progress.toDouble(),
          backgroundColor: Colors.blue[200],
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue));
    } else {
      return const Placeholder(
          strokeWidth: 0,
          color: Colors.transparent,
          fallbackWidth: 0,
          fallbackHeight: 0);
    }
  }
}
