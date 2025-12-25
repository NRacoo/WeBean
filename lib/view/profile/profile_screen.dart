import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child:Column(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  'Profile Screen'
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}
