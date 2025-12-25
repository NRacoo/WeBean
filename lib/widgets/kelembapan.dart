import 'package:flutter/material.dart';

class KelembapanCard extends StatelessWidget {
  final double kelembapan;
  final String status;

  const KelembapanCard({super.key, this.status = 'Status: ', required this.kelembapan});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0xFF5E936C),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            status,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              "$kelembapan%",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            ),
          )
        ],
      ),
    );
  }
}
