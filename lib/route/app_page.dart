import 'package:get/route_manager.dart';
import 'package:webean/bindings/main_binding.dart';
import 'package:webean/main_screen.dart';
import 'package:webean/route/app_route.dart';
import 'package:webean/view/splash/splash_screen.dart';

class AppPage {
  static var list = [
    GetPage(
      name: AppRoute.main,
      page:() => MainScreen(),
      binding: MainBinding(),
    ),
    GetPage(
      name:AppRoute.splash,
      page: () => const SplashScreen()
    ),
  ];
}