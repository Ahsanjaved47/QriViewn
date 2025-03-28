import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:task_1/constants/const.dart';
import 'google_maps.dart';
import 'global_history_list.dart';

class HistoryScreen extends StatefulWidget {
  final String? name;
  final List<String> historyList;

  const HistoryScreen({super.key, this.name, required this.historyList});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final List<Map<String, dynamic>> _historyItems = [];

  @override
  void initState() {
    super.initState();
    debugPrint('Received historyList in HistoryScreen: ${widget.historyList}');
    _loadSavedMarkers();
  }

  void _loadSavedMarkers() {
    debugPrint('Loading saved markers...');
    debugPrint('History List: ${widget.historyList}');

    for (var item in widget.historyList) {
      debugPrint('Processing item: $item');

      List<String> parts = item.split('|');
      if (parts.length >= 3) {
        String title = parts[0];
        String currentPosition = parts[1];
        List<String> markers = parts[2].split(';');

        List<Map<String, double>> markerPositions = [];
        for (var marker in markers) {
          List<String> coords = marker.split(',');
          if (coords.length == 2) {
            double lat = double.tryParse(coords[0]) ?? 0.0;
            double long = double.tryParse(coords[1]) ?? 0.0;
            markerPositions.add({'lat': lat, 'long': long});
          }
        }

        debugPrint('Parsed Data - Title: $title, Current Position: $currentPosition, Markers: $markerPositions');

        _addHistoryItem(title, currentPosition, markerPositions);
      } else {
        debugPrint('Invalid item format: $item');
      }
    }
  }

  void _addHistoryItem(String title, String currentPosition, List<Map<String, double>> markerPositions) {
    setState(() {
      _historyItems.add({
        'title': title,
        'currentPosition': currentPosition,
        'markers': markerPositions,
      });
    });
  }

  void _deleteHistoryItem(int index) {
    setState(() {

      _historyItems.removeAt(index);


      globalHistoryList.removeAt(index);

      debugPrint('Updated globalHistoryList after deletion: $globalHistoryList');
    });
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
                    item['title'],
                    style: KTitleStyle
                  ),
                  const SizedBox(height: 8),


                  Text(
                    'Current Position: ${item['currentPosition']}',
                    style: KCurrentLocationStyle,
                  ),
                  const SizedBox(height: 8),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                      IconButton(
                        icon: KDeleteButtonStyle,
                        onPressed: () => _deleteHistoryItem(index),
                      ),


                      IconButton(
                        icon: KMapButtonStyle,
                        onPressed: () {
                          Set<Marker> markers = {};
                          for (var marker in item['markers']) {
                            markers.add(
                              Marker(
                                markerId: MarkerId('${marker['lat']}_${marker['long']}'),
                                position: LatLng(marker['lat']!, marker['long']!),
                              ),
                            );
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GoogleMapScreen(
                                markers: markers,
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
          ).then((value) {
            if (value != null) {

              setState(() {
                _loadSavedMarkers();
              });
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}