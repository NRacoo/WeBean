import 'package:flutter/material.dart';
import 'package:webean/widgets/periode_card.dart';

class PeriodePanenScreen extends StatelessWidget {
  const PeriodePanenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF235347),
        title: const Text(
          'Semua Periode Panen',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: PeriodePanen(),
      ),
    );
  }
}
