// lib/screens/session_records_screen.dart
import 'package:flutter/material.dart';
import 'package:webean/service/device_service.dart';

class SessionRecordsScreen extends StatefulWidget {
  final String sessionId;
  const SessionRecordsScreen({super.key, required this.sessionId});

  @override
  State<SessionRecordsScreen> createState() => _SessionRecordsScreenState();
}

class _SessionRecordsScreenState extends State<SessionRecordsScreen> {
  final _api = DeviceApiService();
  List<dynamic> _records = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchRecords();
  }

  Future<void> _fetchRecords() async {
    try {
      final data = await _api.getSessionsRecord(widget.sessionId);
      setState(() => _records = data);
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A3C34),
      appBar: AppBar(
        backgroundColor: const Color(0xFF235347),
        title: const Text('Detail Sesi', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
          ? Center(
              child: Text(
                _error!,
                style: const TextStyle(color: Colors.redAccent),
              ),
            )
          : _records.isEmpty
          ? const Center(
              child: Text(
                'Tidak ada record',
                style: TextStyle(color: Colors.white70),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _records.length,
              itemBuilder: (_, i) => _buildRecordTile(_records[i]),
            ),
    );
  }

  Widget _buildRecordTile(Map<String, dynamic> r) {
    final ts = r['timestamp'] != null
        ? DateTime.parse(r['timestamp']).toLocal()
        : null;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF235347),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ts != null
                    ? '${ts.hour.toString().padLeft(2, '0')}:${ts.minute.toString().padLeft(2, '0')}:${ts.second.toString().padLeft(2, '0')}'
                    : '-',
                style: const TextStyle(color: Colors.white54, fontSize: 11),
              ),
              const SizedBox(height: 4),
              Text(
                'Baik: ${r['baik']}   Cacat: ${r['cacat']}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Baik: ${r['totalBaik']}',
                style: const TextStyle(color: Colors.greenAccent, fontSize: 12),
              ),
              Text(
                'Cacat: ${r['totalCacat']}',
                style: const TextStyle(color: Colors.redAccent, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
