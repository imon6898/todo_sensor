import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../routes/app_routes.dart';

class WebViewScreenController extends GetxController {
  late WebViewController webController;
  bool isLoading = true;
  String title = '';
  String url = "";

  @override
  void onInit() {
    super.onInit();

    title = Get.arguments[0];
    url = Get.arguments[1];


     webController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            isLoading = false;
            update();
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            // success/failed/cancelled/duplicate/insufficient

            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));

  }

}