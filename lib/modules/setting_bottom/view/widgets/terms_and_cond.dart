import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../controller/webview_controller.dart';

class TermsAndCond extends StatelessWidget {
  final MyWebViewController webViewController = Get.put(MyWebViewController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms and Condition'),
      ),
      body: WebViewWidget(
        controller: WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(Uri.parse(
              'https://www.termsfeed.com/live/4f9467ed-2da1-4231-a350-034f033e591b')),
      ),
    );
  }
}
