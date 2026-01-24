import 'package:flutter/material.dart';
import 'package:webean/widgets/kelembapan.dart';
import 'package:webean/widgets/suhu_card.dart';
import 'package:webean/widgets/panen_card.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Coffee Bean Health Status',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20),
                PeriodePanen(),
                const SizedBox(height: 16),
                KelembapanCard(kelembapan: 65, status: 'Humidity'),
                const SizedBox(height: 16),
                SuhuCard(suhu: 28.5, status: 'Temperature'),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
