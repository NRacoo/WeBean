import 'package:flutter/material.dart';
import 'package:webean/widgets/profile_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child:Column(
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
                      bottomRight: Radius.circular(200)
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 30,),
                      Center(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color(0xFF5E936C),
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(110)
                          ),
                        ),
                      ),
                      const SizedBox(height: 30,),
                      const Text(
                        '(username)',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            Expanded(
              child:
                SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: 
                        const Text(
                          'Edit Profile',
                          style: 
                          TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      ProfileCard()
                    ],
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}
