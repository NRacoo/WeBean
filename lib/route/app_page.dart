import 'package:get/route_manager.dart';
import 'package:webean/route/app_route.dart';
import 'package:webean/view/dashboard/dashboard_screen.dart';
import 'package:webean/view/splash/splash_screen.dart';

class AppPage {
  static var list = [
    GetPage(
      name: AppRoute.dashboard,
      page:() => const HomeScreen()
    ),
    GetPage(
      name:AppRoute.splash,
      page: () => const SplashScreen()
    )
  ];
}