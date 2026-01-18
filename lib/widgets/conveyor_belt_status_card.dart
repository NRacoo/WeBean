import 'package:flutter/material.dart';

class ConveyorBeltStatusCard extends StatelessWidget {
  final bool isRunning;
  final String status;

  const ConveyorBeltStatusCard({
    super.key,
    this.status = 'Conveyor Belt',
    required this.isRunning,
  });

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
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              isRunning ? 'ON' : 'OFF',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: isRunning ? Colors.greenAccent : Colors.redAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
