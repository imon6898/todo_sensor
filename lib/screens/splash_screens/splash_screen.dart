import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import 'controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashScreenController>(builder: (controller) {
      return Scaffold(
        body: Center(
          child: ScaleTransition(
            scale: controller.scaleAnimation,
            child: Shimmer.fromColors(
              baseColor: Colors.black,
              highlightColor: Colors.grey[100]!,
              child: Image.asset(
                'assets/images/app_icon.png',
                width: 400,
                height: 400,
              ),
            ),
          ),
        ),
      );
    });
  }
}
