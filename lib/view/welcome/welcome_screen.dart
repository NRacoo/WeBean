import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:webean/route/app_route.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext build) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/login.png', fit: BoxFit.cover),
          ),

          Positioned(
            right: 20,
            left: 20,
            bottom: 700,
            child: const Text(
              'Selamat Datang',
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            right: 20,
            left: 20,
            bottom: 610,
            child: const Text(
              'Halo! Silahkan masuk dengan akun Anda untuk mulai menggunakan aplikasi.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child: Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(bottom: 40),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.toNamed(AppRoute.login);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF163832),
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 50)
                        ),
                        child: const Text('Masuk', style: TextStyle(fontSize: 14),),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.toNamed(AppRoute.register);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          minimumSize: const Size(double.infinity, 50)
                        ),
                        child: const Text('Daftar', style: TextStyle(fontSize: 14),),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
