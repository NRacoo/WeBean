import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:webean/route/app_page.dart';
import 'package:webean/route/app_route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'WeBean',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoute.splash,
      getPages: AppPage.list,
    );
  }
}
