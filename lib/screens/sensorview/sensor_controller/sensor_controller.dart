import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../models/sensor_model.dart';

class SensorController extends GetxController {
  var gyroData = SensorData(0, 0, 0).obs;
  var accelerometerData = SensorData(0, 0, 0).obs;

  final RxList<SensorData> gyroHistory = RxList<SensorData>();
  final RxList<SensorData> accelerometerHistory = RxList<SensorData>();

  Timer? demoDataTimer;
  final Random random = Random();
  bool isMeeting = true;

  @override
  void onInit() {
    super.onInit();
    startGeneratingDemoData();
  }

  @override
  void onClose() {
    demoDataTimer?.cancel();
    super.onClose();
  }

  void startGeneratingDemoData() {
    demoDataTimer = Timer.periodic(const Duration(milliseconds: 500), (Timer t) {
      // Gyro data simulation
      double multiplierGyro = isMeeting ? 0.1 : 2;  // Meeting and Walking scenario
      double gyroX = _getRandomValue(multiplierGyro);
      double gyroY = _getRandomValue(multiplierGyro);
      double gyroZ = _getRandomValue(multiplierGyro);

      gyroHistory.add(SensorData(gyroX, gyroY, gyroZ));
      if (gyroHistory.length > 500) {
        gyroHistory.removeAt(0);
      }

      // Accelerometer data simulation
      double multiplierAcc = 0.1;  // Lower amplitude for accelerometer
      double accX = _getRandomValue(multiplierAcc);
      double accY = _getRandomValue(multiplierAcc);
      double accZ = _getRandomValue(multiplierAcc);

      accelerometerHistory.add(SensorData(accX, accY, accZ));
      if (accelerometerHistory.length > 500) {
        accelerometerHistory.removeAt(0);
      }

      // Switch scenarios randomly for gyro
      if (random.nextInt(100) < 2) {  // 2% chance of switching scenario
        isMeeting = !isMeeting;
      }

      checkAlert(gyroX, gyroY, gyroZ);
    });
  }


  double _getRandomValue(double multiplier) {
    return (-0.2 + random.nextDouble() * 0.4) * multiplier;
  }

  void checkAlert(double x, double y, double z) {
    if ((x.abs() + y.abs() + z.abs()) / 3 > 0.5) {
      Get.snackbar('ALERT', 'High movement detected!');
    }
  }


  // Gyroscope Graph
  Widget buildGyroGraph(String label) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide( width: 1, color: Colors.grey)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              label,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
          Divider(height: 1, color: Colors.grey,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(() {
                return SfCartesianChart(
                  primaryXAxis: NumericAxis(
                    majorGridLines: MajorGridLines(width: 0),
                  ),
                  primaryYAxis: NumericAxis(
                    axisLine: AxisLine(width: 0),
                    majorTickLines: MajorTickLines(size: 0),
                  ),
                  series: <LineSeries<SensorData, int>>[
                    LineSeries<SensorData, int>(
                      dataSource: gyroHistory,
                      xValueMapper: (SensorData data, _) => gyroHistory.toList().indexOf(data),
                      yValueMapper: (SensorData data, _) => data.x,
                      name: 'X Axis',
                      color: Colors.blue,
                    ),
                    LineSeries<SensorData, int>(
                      dataSource: gyroHistory.toList(),
                      xValueMapper: (SensorData data, _) => gyroHistory.toList().indexOf(data),
                      yValueMapper: (SensorData data, _) => data.y,
                      name: 'Y Axis',
                      color: Colors.green,
                    ),
                    LineSeries<SensorData, int>(
                      dataSource: gyroHistory.toList(),
                      xValueMapper: (SensorData data, _) => gyroHistory.toList().indexOf(data),
                      yValueMapper: (SensorData data, _) => data.z,
                      name: 'Z Axis',
                      color: Colors.red,
                    ),
                  ],
                );
              }
            ),
          ),
        ],
      ),
    );
  }

  // Accelerometer Graph
  Widget buildAccelerometerGraph(String label) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide( width: 1, color: Colors.grey)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                ),

              ],
            ),
          ),
          Divider(height: 1, color: Colors.grey,),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SfCartesianChart(
                  primaryXAxis: NumericAxis(
                    majorGridLines: MajorGridLines(width: 0),
                  ),
                  primaryYAxis: NumericAxis(
                    axisLine: AxisLine(width: 0),
                    majorTickLines: MajorTickLines(size: 0),
                  ),
                  series: <LineSeries<SensorData, int>>[
                    LineSeries<SensorData, int>(
                      dataSource: accelerometerHistory,
                      xValueMapper: (SensorData data, _) => accelerometerHistory.indexOf(data),
                      yValueMapper: (SensorData data, _) => data.x,
                      name: 'X Axis',
                      color: Colors.red,
                    ),
                    LineSeries<SensorData, int>(
                      dataSource: accelerometerHistory,
                      xValueMapper: (SensorData data, _) => accelerometerHistory.indexOf(data),
                      yValueMapper: (SensorData data, _) => data.y,
                      name: 'Y Axis',
                      color: Colors.green,
                    ),
                    LineSeries<SensorData, int>(
                      dataSource: accelerometerHistory,
                      xValueMapper: (SensorData data, _) => accelerometerHistory.indexOf(data),
                      yValueMapper: (SensorData data, _) => data.z,
                      name: 'Z Axis',
                      color: Colors.blue,
                    ),
                  ],
                ),
                SfCartesianChart(
                  primaryXAxis: NumericAxis(
                    majorGridLines: MajorGridLines(width: 0),
                  ),
                  primaryYAxis: NumericAxis(
                    axisLine: AxisLine(width: 0),
                    majorTickLines: MajorTickLines(size: 0),
                  ),
                  series: <LineSeries<SensorData, int>>[
                    LineSeries<SensorData, int>(
                      dataSource: accelerometerHistory,
                      xValueMapper: (SensorData data, _) => accelerometerHistory.indexOf(data),
                      yValueMapper: (SensorData data, _) => data.x,
                      name: 'X Axis',
                      color: Colors.red,
                    ),
                    LineSeries<SensorData, int>(
                      dataSource: accelerometerHistory,
                      xValueMapper: (SensorData data, _) => accelerometerHistory.indexOf(data),
                      yValueMapper: (SensorData data, _) => data.y,
                      name: 'Y Axis',
                      color: Colors.green,
                    ),
                    LineSeries<SensorData, int>(
                      dataSource: accelerometerHistory,
                      xValueMapper: (SensorData data, _) => accelerometerHistory.indexOf(data),
                      yValueMapper: (SensorData data, _) => data.z,
                      name: 'Z Axis',
                      color: Colors.blue,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
