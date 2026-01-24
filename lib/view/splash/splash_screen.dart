import 'package:flutter/material.dart';
import 'dart:async';
import 'package:get/get.dart';
import 'package:webean/route/app_route.dart';
import 'package:webean/utils/secure_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    final token = await SecureStorage.getToken();

    debugPrint('SPLASH TOKEN => $token');

    await Future.delayed(const Duration(seconds: 1));

    if (token != null) {
      Get.offAllNamed(AppRoute.main);
    } else {
      Get.offAllNamed(AppRoute.welcome);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0B2B26),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/webean.png', width: 300, height: 300),
              const SizedBox(height: 0),
              const Text(
                'Step Shape Destinies',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 4),
              SizedBox(
                width: 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    color: Colors.white,
                    backgroundColor: Colors.white24,
                    minHeight: 6,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
