import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyWebViewController extends GetxController {
  late WebViewController webViewController;
  var isLoading = true.obs;

  void setWebViewController(WebViewController controller) {
    webViewController = controller;
  }
}
