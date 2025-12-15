import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class BranchMapPage extends StatefulWidget {
  final String branchName;
  final String? address;
  final double lat;
  final double lng;

  const BranchMapPage({
    super.key,
    required this.branchName,
    required this.lat,
    required this.lng,
    this.address,
  });

  @override
  State<BranchMapPage> createState() => _BranchMapPageState();
}

class _BranchMapPageState extends State<BranchMapPage> {
  late final MapController _mapController;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {
    final center = LatLng(widget.lat, widget.lng);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.branchName),
        centerTitle: true,
      ),
      body: Column(
        children: [
          if (widget.address != null && widget.address!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  const Icon(Icons.location_on_outlined),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.address!,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Expanded(
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: center,
                initialZoom: 15,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.step_app',
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: center,
                      width: 48,
                      height: 48,
                      child: const Icon(
                        Icons.location_pin,
                        size: 48,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _mapController.move(center, 15);
        },
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
