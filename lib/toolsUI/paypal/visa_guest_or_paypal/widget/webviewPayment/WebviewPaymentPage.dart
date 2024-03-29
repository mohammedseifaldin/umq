import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:umq/toolsUI/paypal/visa_guest_or_paypal/shared/ToolsPayment.dart';

typedef WebviewPaymentUrlChange = Function(String urlChangeTo);

class WebviewPaymentPage extends StatefulWidget {
  String? url;
  WebviewPaymentUrlChange? urlChange;

  WebviewPaymentPage({
    required String this.url,
    required WebviewPaymentUrlChange this.urlChange,
  });

  @override
  WebviewPaymentState createState() {
    var state = WebviewPaymentState(url: url!, urlChange: urlChange!);
    return state;
  }
}

class WebviewPaymentState extends State<WebviewPaymentPage> {
  int progress = 0;

  String? url;

  WebviewPaymentUrlChange? urlChange;

  WebviewPaymentState(
      {required String this.url,
      required WebviewPaymentUrlChange this.urlChange});

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
      InAppWebWidgetCustom(),

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

  Widget InAppWebWidgetCustom() {
    URLRequest uri = URLRequest(url: WebUri.uri(Uri.parse(url!)));
    Log.i("InAppWebWidgetCustom() - url: $url");

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
        Log.i("InAppWebWidgetCustom() - url: $url");
        urlChange!(url.toString());
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
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue));
    } else {
      return Placeholder(
          strokeWidth: 0,
          color: Colors.transparent,
          fallbackWidth: 0,
          fallbackHeight: 0);
    }
  }
}
