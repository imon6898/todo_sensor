import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../custom_widget/LoadingOverlay.dart';
import '../../utils/color_const.dart';
import 'controller/web_view_screen_controller.dart';

class WebViewScreen extends StatelessWidget {
  const WebViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WebViewScreenController>(builder: (controller) {
      return Scaffold(
        backgroundColor: ColorConst.BG_COLOR,
        body: SafeArea(
          child: LoadingOverlay(
            isLoading: controller.isLoading,
            child: WebViewWidget(controller: controller.webController),
          ),
        ),
      );
    });
  }
}
