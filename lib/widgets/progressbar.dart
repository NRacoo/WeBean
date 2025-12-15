import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double value;
  const ProgressBar({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: LinearProgressIndicator(
          value: value,
          minHeight: 5,
          backgroundColor: Colors.white,
          valueColor: const AlwaysStoppedAnimation(Color(0xFF2F4F3E)),
        ),
      ),
    );
  }
}
