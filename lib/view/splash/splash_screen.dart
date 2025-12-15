import 'package:flutter/material.dart';
import 'dart:async';
import 'package:get/get.dart';
import 'package:webean/route/app_route.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    Timer(const Duration(seconds: 3), (){
      Get.offAllNamed(AppRoute.dashboard);
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xFF3E5F44),
      body:Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/webean.png',
                width: 300,
                height: 300,
              ),
              const SizedBox(height: 0),
              const Text(
                'Step Shape Destinies',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontStyle: FontStyle.italic
                ),
              ),
              const SizedBox(
                height: 4,
              ),
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
          )
        ),
      )
    );
  }
}

