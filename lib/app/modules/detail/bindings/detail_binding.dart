import 'package:get/get.dart';
import 'package:tickertape_assignment/app/modules/detail/controller/detail_controller.dart';

class DetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DetailController());
  }
}
