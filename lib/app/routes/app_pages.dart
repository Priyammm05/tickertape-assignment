// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';
import 'package:tickertape_assignment/app/modules/detail/bindings/detail_binding.dart';
import 'package:tickertape_assignment/app/modules/detail/view/detail_view.dart';
import 'package:tickertape_assignment/app/modules/home/bindings/home_binding.dart';
import 'package:tickertape_assignment/app/modules/home/view/home_view.dart';
import 'package:tickertape_assignment/app/modules/search/binding/earch_binding.dart';
import 'package:tickertape_assignment/app/modules/search/view/search_view.dart';
import 'package:tickertape_assignment/app/modules/splash/binding/splash_binding.dart';
import 'package:tickertape_assignment/app/modules/splash/view/splash_view.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.splash;

  static final routes = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.search,
      page: () => const SearchView(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: Routes.detail,
      page: () => const DetailView(),
      binding: DetailBinding(),
    ),
  ];
}
