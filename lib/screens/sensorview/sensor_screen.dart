import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'sensor_controller/sensor_controller.dart';

class SensorView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SensorController>(builder: (sensorController) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Sensor Tracking'),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Gyroscope data graph
                sensorController.buildGyroGraph('Gyro'),
                SizedBox(height: 20),
                // Accelerometer data graph
                sensorController.buildAccelerometerGraph('Accelerometer'),
              ],
            ),
          ),
        ),
      );
    });
  }
}
