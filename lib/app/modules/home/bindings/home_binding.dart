import 'package:get/get.dart';
import 'package:tickertape_assignment/app/modules/home/controller/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}
