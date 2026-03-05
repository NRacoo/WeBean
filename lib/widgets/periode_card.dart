import 'package:flutter/material.dart';
import 'package:webean/service/device_service.dart';
import 'package:webean/view/sessions/session_records_screen.dart';
import 'package:webean/widgets/progressbar.dart';

class PeriodePanen extends StatefulWidget {
  const PeriodePanen({super.key});

  @override
  State<PeriodePanen> createState() => _PeriodePanenState();
}

class _PeriodePanenState extends State<PeriodePanen> {
  final _api = DeviceApiService();

  List<dynamic> _sessions = [];
  int _currentPage = 1;
  int _totalPages = 1;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchSessions();
  }

  Future<void> _fetchSessions({int page = 1}) async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final data = await _api.getSessions(page: page, limit: 5);
      setState(() {
        _sessions = data['data'] ?? [];
        _totalPages = data['totalPages'] ?? 1;
        _currentPage = data['page'] ?? 1;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading)
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFF235347)),
      );
    if (_error != null)
      return Center(
        child: Text(_error!, style: const TextStyle(color: Colors.white70)),
      );
    if (_sessions.isEmpty)
      return const Center(
        child: Text('Belum ada sesi', style: TextStyle(color: Colors.white)),
      );

    return Column(
      children: [
        ..._sessions.map((sesi) => _buildCard(context, sesi)),
        if (_totalPages > 1) _buildPagination(),
      ],
    );
  }

  Widget _buildCard(BuildContext context, Map<String, dynamic> sesi) {
    final totalBaik = (sesi['totalBaik'] ?? 0) as num;
    final totalCacat = (sesi['totalCacat'] ?? 0) as num;
    final total = totalBaik + totalCacat;
    final baikRatio = total > 0 ? totalBaik / total : 0.0;
    final cacatRatio = total > 0 ? totalCacat / total : 0.0;

    final startedAt = sesi['startedAt'] != null
        ? DateTime.parse(sesi['startedAt']).toLocal()
        : null;
    final endedAt = sesi['endedAt'] != null
        ? DateTime.parse(sesi['endedAt']).toLocal()
        : null;

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => SessionRecordsScreen(sessionId: sesi['id']),
        ),
      ),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFF235347),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  startedAt != null
                      ? 'Sesi ${startedAt.day}/${startedAt.month}/${startedAt.year}'
                      : 'Sesi Baru',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  '$total Biji',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
                const SizedBox(width: 6),
                const Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                  size: 18,
                ),
              ],
            ),
            if (startedAt != null) ...[
              const SizedBox(height: 4),
              Text(
                endedAt != null
                    ? '${_fmt(startedAt)} - ${_fmt(endedAt)}'
                    : 'Mulai: ${_fmt(startedAt)} Berlangsung',
                style: const TextStyle(color: Colors.white54, fontSize: 11),
              ),
            ],

            const SizedBox(height: 14),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Kualitas Baik',
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
                Text(
                  '$totalBaik',
                  style: const TextStyle(
                    color: Color(0xFFE9E9CB),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            ProgressBar(value: baikRatio.toDouble()),
            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Kualitas Cacat',
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
                Text(
                  '$totalCacat',
                  style: const TextStyle(color: Color(0XFFB91C2D), fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 4),
            ProgressBar(value: cacatRatio.toDouble()),
          ],
        ),
      ),
    );
  }

  Widget _buildPagination() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: _currentPage > 1
                ? () => _fetchSessions(page: _currentPage - 1)
                : null,
            icon: const Icon(Icons.chevron_left, color: Colors.white),
          ),
          Text(
            '$_currentPage / $_totalPages',
            style: const TextStyle(color: Colors.white),
          ),
          IconButton(
            onPressed: _currentPage > 1
                ? () => _fetchSessions(page: _currentPage + 1)
                : null,
            icon: const Icon(Icons.chevron_right, color: Colors.white),
          ),
        ],
      ),
    );
  }

  String _fmt(DateTime dt) =>
      '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
}
