import 'package:flutter/material.dart';
import 'package:webean/widgets/panen_card.dart';
import 'package:webean/widgets/suhu_card.dart';
import 'package:webean/widgets/kelembapan.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: const BoxDecoration(
                    color: Color(0xFF3E5F44),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(200),
                      bottomRight: Radius.circular(200),
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        'Hai, (user)!',
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Your Coffee Journey Starts here.',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      const SizedBox(height: 40),
                      Positioned(
                        bottom: -50,
                        width: 200,
                        height: 120,
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF5E936C),
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(24),
                              child: Image.asset(
                                "assets/images/bean.png",
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),

                )
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Kualitas Panen',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    PeriodePanen(),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'Suhu',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 155,),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'Kelembapan',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(children:const [
                      Expanded(child: SuhuCard(suhu: 14)),
                      SizedBox(width: 10,),
                      Expanded(child: KelembapanCard(kelembapan: 65))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
