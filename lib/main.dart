import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:tickertape_assignment/app/routes/app_pages.dart';
import 'package:tickertape_assignment/app/services/network_service.dart';
import 'package:tickertape_assignment/app/services/news_api_service.dart';

void main() async {
  await handleInitializations();
  runApp(const MainApp());
}

Future<void> handleInitializations() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await dotenv.load(fileName: "assets/.env");
  Get.put(NetworkService(), permanent: true);
  await NewsApiService().initialize();
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
