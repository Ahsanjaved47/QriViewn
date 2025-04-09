import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../database/database.dart';
import 'google_maps.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final db = AppDatabase();
  List<HistoryItem> _historyItems = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final items = await db.select(db.historyItems).get();
    setState(() => _historyItems = items);
  }

  Future<void> _deleteItem(int id) async {
    await (db.delete(db.historyItems)..where((t) => t.id.equals(id))).go();
    await _loadHistory();
  }

  Set<Marker> _parseMarkers(String markersString) {
    return markersString.split(';').map((coord) {
      final latLng = coord.split(',');
      return Marker(
        markerId: MarkerId('marker_${latLng[0]}_${latLng[1]}'),
        position: LatLng(
          double.parse(latLng[0]),
          double.parse(latLng[1]),
        ),
      );
    }).toSet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        backgroundColor: const Color(0xFF017373),
      ),
      body: _historyItems.isEmpty
          ? const Center(child: Text('No history found'))
          : ListView.builder(
        itemCount: _historyItems.length,
        itemBuilder: (context, index) {
          final item = _historyItems[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            color: const Color(0xFF004D60),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Current Position: ${item.currentPosition}',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteItem(item.id),
                      ),
                      IconButton(
                        icon: const Icon(Icons.map, color: Colors.green),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) => GoogleMapScreen(
                                markers: _parseMarkers(item.markers),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const GoogleMapScreen(),
            ),
          ).then((_) => _loadHistory());
        },
        backgroundColor: const Color(0xFF017373),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
