import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:tickertape_assignment/app/constants/snackbar_utils.dart';

class NetworkService extends GetxController {
  final Connectivity _connectivity = Connectivity();
  RxBool isConnected = true.obs;

  @override
  void onInit() {
    super.onInit();
    _initConnectivity();
    _connectivity.onConnectivityChanged
        .listen((List<ConnectivityResult> results) {
      _updateConnectionStatus(results);
    });
  }

  Future<void> _initConnectivity() async {
    try {
      final result = await _connectivity.checkConnectivity();
      _updateConnectionStatus([result.first]);
    } catch (e) {
      isConnected.value = false;
    }
  }

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    if (results.isEmpty) {
      isConnected.value = false;
      return;
    }

    isConnected.value = results.first != ConnectivityResult.none;
    if (!isConnected.value) {
      SnackbarUtils.showSnackbar(
        message: "No internet connection. Showing cached data.",
        isSuccess: false,
      );
    }
  }
}
