import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geocoding/geocoding.dart';
import 'package:task_1/constants/const.dart';
import 'global_history_list.dart';

class GoogleMapScreen extends StatefulWidget {
  final Set<Marker>? markers;

  const GoogleMapScreen({super.key, this.markers});

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  late GoogleMapController mapController;
  LatLng? _currentPosition;
  final TextEditingController _searchController = TextEditingController();
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};

  @override
  void initState() {
    super.initState();
    _checkPermissions();


    if (widget.markers != null) {
      _markers.addAll(widget.markers!);
    }

    _getCurrentLocation();
  }

  Future<void> _checkPermissions() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      _getCurrentLocation();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location permission is denied')),
      );
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      LatLng newPosition = LatLng(position.latitude, position.longitude);

      setState(() {
        _currentPosition = newPosition;
        _addMarker(newPosition, "Current Location", isCurrent: true);
        _moveCamera(newPosition);
      });
    } catch (e) {
      debugPrint('Error fetching location: $e');
    }
  }

  void _addMarker(LatLng position, String label, {bool isCurrent = false, bool isDestination = false}) {
    setState(() {
      final markerId = isCurrent ? 'current' : 'marker_${_markers.length}';
      _markers.add(
        Marker(
          markerId: MarkerId(markerId),
          position: position,
          infoWindow: InfoWindow(title: label),
          icon: isCurrent
              ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)
              : BitmapDescriptor.defaultMarker,
        ),
      );


      if (isDestination && _currentPosition != null) {
        _addPolyline(_currentPosition!, position);
      }
    });
  }

  void _addPolyline(LatLng start, LatLng end) {
    Polyline polyline = Polyline(
      polylineId: PolylineId("route_${_polylines.length}"),
      color: Colors.blue,
      width: 5,
      points: [start, end],
    );

    setState(() {
      _polylines.add(polyline);
    });
  }

  void _moveCamera(LatLng position) {
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: position, zoom: 14),
      ),
    );
  }

  void _searchLocation() async {
    String query = _searchController.text;
    if (query.isEmpty) return;

    try {
      List<Location> locations = await locationFromAddress(query);
      if (locations.isNotEmpty) {
        Location location = locations.first;
        LatLng position = LatLng(location.latitude, location.longitude);

        _addMarker(position, query, isDestination: true);
        _moveCamera(position);
      }
    } catch (e) {
      debugPrint('Error searching location: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location not found')),
      );
    }
  }

  void _showInputDialog() {
    String inputTitle = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enter Title'),
          content: TextField(
            onChanged: (value) => inputTitle = value,
            decoration: const InputDecoration(hintText: 'Input name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (inputTitle.isNotEmpty && _markers.isNotEmpty && _currentPosition != null) {
                  String markersString = _markers.map((marker) {
                    return '${marker.position.latitude},${marker.position.longitude}';
                  }).join(';');

                  globalHistoryList.add('$inputTitle|${_currentPosition!.latitude},${_currentPosition!.longitude}|$markersString');

                  debugPrint('Updated globalHistoryList: $globalHistoryList');

                  Navigator.pop(context);
                  Navigator.pop(context, globalHistoryList);
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _onCameraMove(CameraPosition position) {
    _currentPosition = position.target;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) => mapController = controller,
            initialCameraPosition: const CameraPosition(
              target: LatLng(37.7749, -122.4194),
              zoom: 14.0,
            ),
            markers: _markers,
            polylines: _polylines,
            onCameraMove: _onCameraMove,
            onTap: (LatLng position) {
              _addMarker(position, "Marker ${_markers.length}");
            },
          ),

          const Center(
            child: KAddIconStyle,
          ),

          Positioned(
            bottom: 170,
            left: 90,
            right: 90,
            child: ElevatedButton(
              onPressed: _showInputDialog,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text('Save', style: TextStyle(color: Colors.white),),
            ),
          ),

          Positioned(
            bottom: 100,
            left: 45,
            right: 45,
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search location...',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 40,
            left: 90,
            right: 90,
            child: ElevatedButton(
              onPressed: _searchLocation,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text('Proceed',style: TextStyle(color: Colors.white),),
            ),
          ),

          Positioned(
            top: 150,
            right: 16,
            child: FloatingActionButton(
              onPressed: _getCurrentLocation,
              backgroundColor: Colors.blue,
              child: const Icon(Icons.my_location, color: Colors.white),
            ),
          ),

          Positioned(
            top: 220,
            right: 16,
            child: FloatingActionButton(
              onPressed: () {
                if (_currentPosition != null) {
                  _addMarker(_currentPosition!, "Marker ${_markers.length}");
                }
              },
              backgroundColor: Colors.green,
              child: const Icon(Icons.add_location_alt, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

