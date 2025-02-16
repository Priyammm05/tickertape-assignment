import 'package:get/get.dart';
import 'package:tickertape_assignment/app/modules/splash/controller/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}
