// lib/widgets/periode_panen.dart
import 'package:flutter/material.dart';
import 'package:webean/service/device_service.dart';
import 'package:webean/view/periode/periode_panen_screen.dart';
import 'package:webean/widgets/progressbar.dart';

class PanenCard extends StatefulWidget {
  const PanenCard({super.key});

  @override
  State<PanenCard> createState() => _PanenCardState();
}

class _PanenCardState extends State<PanenCard> {
  final _api = DeviceApiService();

  Map<String, dynamic>? _sesi;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchLatest();
  }

  Future<void> _fetchLatest() async {
    setState(() { _loading = true; _error = null; });
    try {
      // ambil 1 sesi terbaru saja
      final data = await _api.getSessions(page: 1, limit: 1);
      final list = data['data'] as List<dynamic>;
      setState(() => _sesi = list.isNotEmpty ? list.first : null);
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return _shell(child: const Center(
        child: CircularProgressIndicator(color: Colors.white54),
      ));
    }

    if (_error != null) {
      return _shell(child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.wifi_off, color: Colors.white54),
            const SizedBox(height: 8),
            Text('Gagal memuat data', style: const TextStyle(color: Colors.white54)),
            TextButton(onPressed: _fetchLatest, child: const Text('Coba lagi', style: TextStyle(color: Colors.greenAccent))),
          ],
        ),
      ));
    }

    if (_sesi == null) {
      return _shell(child: const Center(
        child: Text('Belum ada sesi panen', style: TextStyle(color: Colors.white54, fontSize: 14)),
      ));
    }

    final totalBaik  = (_sesi!['totalBaik']  ?? 0) as num;
    final totalCacat = (_sesi!['totalCacat'] ?? 0) as num;
    final total      = totalBaik + totalCacat;
    final baikRatio  = total > 0 ? (totalBaik  / total).toDouble() : 0.0;
    final cacatRatio = total > 0 ? (totalCacat / total).toDouble() : 0.0;

    final startedAt = _sesi!['startedAt'] != null
        ? DateTime.parse(_sesi!['startedAt']).toLocal()
        : null;

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const PeriodePanenScreen(),
        ),
      ),
      child: _shell(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Periode Panen Saat Ini',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Row(
                    children: [
                      Text(
                        '$total biji',
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 18),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.chevron_right, color: Colors.white54, size: 20),
                    ],
                  ),
                ],
              ),
            ),

            if (startedAt != null)
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 4),
                child: Text(
                  '${startedAt.day}/${startedAt.month}/${startedAt.year}  '
                  '${startedAt.hour.toString().padLeft(2, '0')}:${startedAt.minute.toString().padLeft(2, '0')}',
                  style: const TextStyle(color: Colors.white54, fontSize: 11),
                ),
              ),

            Padding(
              padding: const EdgeInsets.only(left: 10, top: 20, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Kualitas Baik', style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w400)),
                      Text('$totalBaik', style: const TextStyle(color: Color(0xFFE9E9CB), fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 5),
                  ProgressBar(value: baikRatio),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 10, top: 16, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Kualitas Rendah', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400)),
                      Text('$totalCacat', style: const TextStyle(color: Color.fromARGB(255, 165, 6, 22), fontSize: 12)),
                    ],
                  ),
                  ProgressBar(value: cacatRatio),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _shell({required Widget child}) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: const Color(0xFF235347),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}