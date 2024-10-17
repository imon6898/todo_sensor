import 'package:get/get.dart';
import '../screens/sensorview/sensor_controller/sensor_controller.dart';
import '../screens/splash_screens/controller/splash_controller.dart';
import '../screens/todoview/todo_view_controller/todo_view_controller.dart';



class ViewModelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashScreenController>(() => SplashScreenController(), fenix: true);
    Get.lazyPut<TodoController>(() => TodoController(), fenix: true);
    Get.lazyPut<SensorController>(() => SensorController(), fenix: true);
  }
}