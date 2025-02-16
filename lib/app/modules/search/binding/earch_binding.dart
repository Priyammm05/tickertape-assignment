import 'package:get/get.dart';
import 'package:tickertape_assignment/app/modules/search/controller/search_controller.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CustomSearchController());
  }
}
