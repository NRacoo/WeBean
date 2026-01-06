import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webean/controller/getx.dart';
import 'package:webean/view/dashboard/dashboard_screen.dart';
import 'package:webean/view/list/list_screen.dart';
import 'package:webean/view/profile/profile_screen.dart';
import 'package:webean/widgets/navigation.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final NavigationController navC = Get.put(NavigationController(), permanent: true);

  final List<Widget> pages = const [
    HomeScreen(),
    ListScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(
        index: navC.currentIndex.value,
        children: pages,
      )),
      bottomNavigationBar: Obx(() => CustomNavigationBar(
        currentIndex: navC.currentIndex.value,
        )),
    );
  }
}
