import 'package:get/get.dart';
import 'package:tickertape_assignment/app/routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 2));
    Get.offAllNamed(Routes.home);
  }
}
