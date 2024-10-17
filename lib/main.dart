import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:todo_sensor_app/routes/app_pages.dart';
import 'package:todo_sensor_app/routes/app_routes.dart';
import 'package:todo_sensor_app/utils/text_const.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'binding/view_model_binding.dart';

void main() {
  tz.initializeTimeZones();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          builder: FToastBuilder(),
          debugShowCheckedModeBanner: false,
          translations: TextConst(),
          locale: const Locale('en', 'UK'),
          initialBinding: ViewModelBinding(),
          title: 'ToDo Sensor App',
          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.blue,
          ),
          initialRoute: AppRoutes.SplashScreen,
          getPages: AppPages.list,
        );
      },
    );
  }
}