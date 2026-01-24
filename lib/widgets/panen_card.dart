import 'package:flutter/material.dart';
import 'package:webean/widgets/progressbar.dart';

class PeriodePanen extends StatelessWidget {
  const PeriodePanen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: Color(0xFF235347),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsetsGeometry.only(
              left: 10,
              top: 10,
              right: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Periode Panen Saat Ini',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '100kg',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsGeometry.only(left: 10, top: 40, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kualitas Baik',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 5,),
                ProgressBar(value: 0.8),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsGeometry.only(left: 10, top:20, right:10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kualitas Rendah',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400
                  ),
                ),
                ProgressBar(value: 0.5)
              ],
            ),
            )
        ],
      ),
    );
  }
}
