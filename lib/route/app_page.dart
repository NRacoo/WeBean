import 'package:get/route_manager.dart';
import 'package:webean/bindings/main_binding.dart';
import 'package:webean/main_screen.dart';
import 'package:webean/route/app_route.dart';
import 'package:webean/view/login/login_screen.dart';
import 'package:webean/view/register/register_screen.dart';
import 'package:webean/view/splash/splash_screen.dart';
import 'package:webean/view/welcome/welcome_screen.dart';

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
    GetPage(
    name: AppRoute.login, 
    page: () => const LoginPage()
    ),
    GetPage(
    name: AppRoute.register, 
    page: () => const RegisterPage()
    ),
    GetPage(
    name: AppRoute.welcome, 
    page: () => const WelcomeScreen()
    )
  ];
}