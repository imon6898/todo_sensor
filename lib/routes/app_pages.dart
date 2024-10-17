import 'package:get/get.dart';
import '../screens/homeview/home_view_screen.dart';
import '../screens/my_home_page.dart';
import '../screens/sensorview/addtaskview.dart';
import '../screens/sensorview/sensor_screen.dart';
import '../screens/splash_screens/splash_screen.dart';
import '../screens/todoview/todo_view_screen.dart';
import 'app_routes.dart';

class AppPages {
  static var list = [
    GetPage(
      name: AppRoutes.SplashScreen,
      page: () => SplashScreen(),
    ),

    GetPage(
      name: AppRoutes.HomeView,
      page: () => HomeView(),
    ),

    GetPage(
      name: AppRoutes.TodoView,
      page: () => TodoView(),
    ),

    GetPage(
      name: AppRoutes.AddTaskView,
      page: () => AddTaskView(),
    ),

    GetPage(
      name: AppRoutes.SensorView,
      page: () => SensorView(),
    ),
    GetPage(
      name: AppRoutes.MyHomePage,
      page: () => MyHomePage(),
    ),


  ];
}
