import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import 'controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashScreenController>(builder: (controller) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ScaleTransition(
                scale: controller.scaleAnimation,
                child: Image.asset(
                  'assets/images/app_icon.png',
                ),
              ),
              Text(
                'Daily To-Do App',
                style: GoogleFonts.sigmar(
                   color: Colors.black,
                   fontWeight: FontWeight.w600,
                   fontSize: 21
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
