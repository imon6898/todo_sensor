import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

import '../../../routes/app_routes.dart';


class SplashScreenController extends GetxController with GetTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> scaleAnimation;


  @override
  void onInit() {
    super.onInit();

    animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    scaleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      ),
    );

    animationController.forward();

    // Retrieve the auth token from local storage


    // Navigate to the appropriate screen after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {

        //Get.offAndToNamed('/homeScreen');
        Get.offAllNamed(AppRoutes.HomeView);

    });
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
