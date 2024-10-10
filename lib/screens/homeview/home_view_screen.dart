import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do and Sensor Tracking'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // First button styled to match the top button in the image
            ElevatedButton(
              onPressed: () => Get.toNamed(AppRoutes.TodoView),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff33CCCC), // Button background color
                padding: EdgeInsets.symmetric(vertical: 20), // Vertical padding
                minimumSize: Size(MediaQuery.of(context).size.width * 0.8, 50), // Button width is 80% of screen width, height set to 50
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // Rounded corners
                ),
              ),
              child: Text(
                'A To-Do List',
                style: TextStyle(fontSize: 18, color: Colors.black), // Text color and size
              ),
            ),
            SizedBox(height: 20), // Add some space between buttons
            // Second button styled to match the bottom button in the image
            ElevatedButton(
              onPressed: () => Get.toNamed(AppRoutes.SensorView),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff3F69FF), // Button background color
                padding: EdgeInsets.symmetric(vertical: 20), // Vertical padding
                minimumSize: Size(MediaQuery.of(context).size.width * 0.8, 50), // Button width is 80% of screen width, height set to 50
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // Rounded corners
                ),
              ),
              child: Text(
                'Sensor Tracking',
                style: TextStyle(fontSize: 18, color: Colors.white), // Text color and size
              ),
            ),

          ],
        ),
      ),
    );
  }
}
