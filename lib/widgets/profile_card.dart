import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: 
      BoxDecoration(
        color: Color(0xFF5E936C),
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         Padding(padding: const EdgeInsetsGeometry.all(20))
        ],
      ),
    );
  }
}
