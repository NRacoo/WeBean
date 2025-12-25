import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webean/route/app_route.dart';

class CustomNavigationBar extends StatelessWidget {
  final int currentIndex;

  const CustomNavigationBar({super.key, required this.currentIndex});

  void _onTap(int index) {
    if (index == currentIndex) return;

    switch (index) {
      case 0:
        Get.offNamed(AppRoute.dashboard);
        break;
      case 1:
        Get.offNamed(AppRoute.list);
        break;
      case 2:
        Get.offNamed(AppRoute.profile);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Color(0xFF3E5F44),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItems(Icons.home_outlined, 0),
          _navItems(Icons.list_alt_outlined, 1),
          _navItems(Icons.person_2_outlined, 2)
        ],
      ),
    );
  }

  Widget _navItems(IconData icon, int index) {
    return GestureDetector(
      onTap: () => _onTap(index),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: currentIndex == index
              ? Colors.white.withValues(alpha:0.15)
              : Colors.transparent,
        ),
        child: Icon(
          icon,
          size: 28,
          color: Colors.white
        ),
      ),
    );
  }
}
