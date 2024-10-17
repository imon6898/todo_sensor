import 'dart:async';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sensors_plus/sensors_plus.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Initialize lists with dummy starting points to avoid rendering issues
  final List<FlSpot> accelerometerSpots = [FlSpot(0, 0)];
  final List<FlSpot> gyroscopeSpots = [FlSpot(0, 0)];
  final List<FlSpot> accelerometerSpotsX = [FlSpot(0, 0)];
  final List<FlSpot> accelerometerSpotsY = [FlSpot(0, 0)];
  final List<FlSpot> accelerometerSpotsZ = [FlSpot(0, 0)];
  final List<FlSpot> gyroscopeSpotsX = [FlSpot(0, 0)];
  final List<FlSpot> gyroscopeSpotsY = [FlSpot(0, 0)];
  final List<FlSpot> gyroscopeSpotsZ = [FlSpot(0, 0)];
  StreamSubscription? _accelerometerSubscription;
  StreamSubscription? _gyroscopeSubscription;
  double time = 0.0;

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    initializeSensors();
    initializeNotifications();
  }

  void initializeSensors() {
    _accelerometerSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        accelerometerSpotsX.add(FlSpot(time, event.x));
        accelerometerSpotsY.add(FlSpot(time, event.y));
        accelerometerSpotsZ.add(FlSpot(time, event.z));
        accelerometerSpots.add(FlSpot(time, event.x + event.y + event.z));
        if (accelerometerSpots.length > 100) {
          accelerometerSpotsX.removeAt(0);
          accelerometerSpotsY.removeAt(0);
          accelerometerSpotsZ.removeAt(0);
          accelerometerSpots.removeAt(0);
        }
        checkForHighMovement(event.x, event.y, event.z);
      });
      time += 0.1;
    });

    _gyroscopeSubscription = gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        gyroscopeSpotsX.add(FlSpot(time, event.x));
        gyroscopeSpotsY.add(FlSpot(time, event.y));
        gyroscopeSpotsZ.add(FlSpot(time, event.z));
        gyroscopeSpots.add(FlSpot(time, event.x + event.y + event.z));
        if (gyroscopeSpots.length > 100) {
          gyroscopeSpotsX.removeAt(0);
          gyroscopeSpotsY.removeAt(0);
          gyroscopeSpotsZ.removeAt(0);
          gyroscopeSpots.removeAt(0);
        }
        checkForHighMovement(event.x, event.y, event.z);
      });
    });
  }

  void checkForHighMovement(double x, double y, double z) {
    if (x.abs() > 20 && y.abs() > 20 ||
        y.abs() > 20 && z.abs() > 20 ||
        x.abs() > 20 && z.abs() > 20) {
      _showAlert();
    }
  }

  void initializeNotifications() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _showAlert() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('high_movement_id', 'High Movement',
            channelDescription: 'Notification when high movement detected',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(0, 'ALERT',
        'High movement detected on multiple axes!', platformChannelSpecifics);
  }

  @override
  void dispose() {
    _accelerometerSubscription?.cancel();
    _gyroscopeSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Gyro', style: Theme.of(context).textTheme.headlineSmall),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.20,
                child: LineChart(
                  // duration: const Duration(milliseconds: 500),
                  LineChartData(
                    lineBarsData: [
                      LineChartBarData(
                        spots: gyroscopeSpotsX,
                        color: Colors.red,
                        isCurved: true,
                        barWidth: 2,
                        dotData: const FlDotData(
                          show: false,
                        ),
                      ),
                      LineChartBarData(
                        spots: gyroscopeSpotsY,
                        color: Colors.green,
                        isCurved: true,
                        barWidth: 2,
                        dotData: const FlDotData(
                          show: false,
                        ),
                      ),
                      LineChartBarData(
                        spots: gyroscopeSpotsZ,
                        color: Colors.blue,
                        isCurved: true,
                        barWidth: 2,
                        dotData: const FlDotData(
                          show: false,
                        ),
                      ),
                    ],
                    titlesData: FlTitlesData(
                        show: true,
                      rightTitles: AxisTitles(drawBelowEverything: false),
                        leftTitles: AxisTitles(sideTitles: SideTitles(reservedSize: 60, showTitles: true)),
                      topTitles: AxisTitles(
                          sideTitles: SideTitles(reservedSize: 30),
                          axisNameSize: 30,
                          axisNameWidget: Text(
                        'Meeting',
                        style: TextStyle(
                           color: Colors.black,
                           fontSize: 14
                        ),
                      ))
                    ),
                    gridData: FlGridData(show: false),
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.20,
                child: LineChart(
                  // duration: const Duration(milliseconds: 500),
                  LineChartData(
                    lineBarsData: [
                      LineChartBarData(
                        spots: gyroscopeSpotsX,
                        color: Colors.red,
                        isCurved: true,
                        barWidth: 2,
                        dotData: const FlDotData(
                          show: false,
                        ),
                      ),
                      LineChartBarData(
                        spots: gyroscopeSpotsY,
                        color: Colors.green,
                        isCurved: true,
                        barWidth: 2,
                        dotData: const FlDotData(
                          show: false,
                        ),
                      ),
                      LineChartBarData(
                        spots: gyroscopeSpotsZ,
                        color: Colors.blue,
                        isCurved: true,
                        barWidth: 2,
                        dotData: const FlDotData(
                          show: false,
                        ),
                      ),
                    ],
                    titlesData: FlTitlesData(
                        show: true,
                        rightTitles: AxisTitles(drawBelowEverything: false),
                        leftTitles: AxisTitles(sideTitles: SideTitles(reservedSize: 60, showTitles: true)),
                        topTitles: AxisTitles(
                            sideTitles: SideTitles(reservedSize: 30),
                            axisNameSize: 30,
                            axisNameWidget: Text(
                              'Walking',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14
                              ),
                            ))
                    ),
                    gridData: FlGridData(show: false),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text('Accelerometer Sensor Data',
                  style: Theme.of(context).textTheme.headlineSmall),
              SizedBox(height: 20),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
                child: LineChart(
                  LineChartData(
                    lineBarsData: [
                      LineChartBarData(
                        spots: accelerometerSpotsX,
                        color: Colors.red,
                        isCurved: true,
                        barWidth: 2,
                        dotData: const FlDotData(
                          show: false,
                        ),
                      ),
                    ],
                    titlesData: FlTitlesData(
                        show: true,
                      rightTitles: AxisTitles(drawBelowEverything: false),
                      leftTitles: AxisTitles(sideTitles: SideTitles(reservedSize: 60, showTitles: true)),
                      topTitles: AxisTitles(drawBelowEverything: false),
                    ),
                    gridData: FlGridData(show: false),
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
                child: LineChart(
                  LineChartData(
                    lineBarsData: [
                      LineChartBarData(
                        spots: accelerometerSpotsY,
                        color: Colors.green,
                        isCurved: true,
                        barWidth: 2,
                        dotData: const FlDotData(
                          show: false,
                        ),
                      ),
                    ],
                    titlesData: FlTitlesData(
                      show: true,
                      rightTitles: AxisTitles(drawBelowEverything: false),
                      leftTitles: AxisTitles(sideTitles: SideTitles(reservedSize: 60, showTitles: true)),
                      topTitles: AxisTitles(drawBelowEverything: false),
                    ),
                    gridData: FlGridData(show: false),
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
                child: LineChart(
                  LineChartData(
                    lineBarsData: [
                      LineChartBarData(
                        spots: accelerometerSpotsZ,
                        color: Colors.blue,
                        isCurved: true,
                        barWidth: 2,
                        dotData: const FlDotData(
                          show: false,
                        ),
                      ),
                    ],
                    titlesData: FlTitlesData(
                      show: true,
                      rightTitles: AxisTitles(drawBelowEverything: false),
                      leftTitles: AxisTitles(sideTitles: SideTitles(reservedSize: 60, showTitles: true)),
                      topTitles: AxisTitles(drawBelowEverything: false),
                    ),
                    gridData: FlGridData(show: false),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
