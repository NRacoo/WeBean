import 'package:get/route_manager.dart';
import 'package:webean/route/app_route.dart';
import 'package:webean/view/dashboard/dashboard_screen.dart';

class AppPage {
  static var list = [
    GetPage(name: AppRoute.dashboard, page:() => const DashboardScreen())
  ];
}