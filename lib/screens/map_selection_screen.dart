import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class MapSelectionScreen extends StatefulWidget {
  const MapSelectionScreen({super.key});

  @override
  State<MapSelectionScreen> createState() => _MapSelectionScreenState();
}

class _MapSelectionScreenState extends State<MapSelectionScreen> {
  GoogleMapController? mapController;

  LatLng? pickup;
  LatLng? destination;

  Set<Marker> markers = {};
  Set<Polyline> polylines = {};

  double distanceKm = 0;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  /// Get user location
  Future<void> _getCurrentLocation() async {
    await Geolocator.requestPermission();

    Position pos = await Geolocator.getCurrentPosition();

    setState(() {
      pickup = LatLng(pos.latitude, pos.longitude);

      markers.add(
        Marker(
          markerId: const MarkerId("pickup"),
          position: pickup!,
          infoWindow: const InfoWindow(title: "Pickup"),
        ),
      );
    });
  }

  /// When user taps map
  void _onMapTap(LatLng position) async {
    setState(() {
      if (pickup == null) {
        pickup = position;

        markers.add(
          Marker(
            markerId: const MarkerId("pickup"),
            position: pickup!,
            infoWindow: const InfoWindow(title: "Pickup"),
          ),
        );
      } else if (destination == null) {
        destination = position;

        markers.add(
          Marker(
            markerId: const MarkerId("destination"),
            position: destination!,
            infoWindow: const InfoWindow(title: "Destination"),
          ),
        );

        _drawRoute();
      }
    });
  }

  /// Draw route between points
  void _drawRoute() {
    if (pickup == null || destination == null) return;

    setState(() {
      polylines.add(
        Polyline(
          polylineId: const PolylineId("route"),
          points: [pickup!, destination!],
          width: 5,
          color: Colors.blue,
        ),
      );

      _calculateDistance();
    });
  }

  /// Calculate distance
  void _calculateDistance() {
    if (pickup == null || destination == null) return;

    double meters = Geolocator.distanceBetween(
      pickup!.latitude,
      pickup!.longitude,
      destination!.latitude,
      destination!.longitude,
    );

    setState(() {
      distanceKm = meters / 1000;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Route")),

      body: Stack(
        children: [

          /// MAP
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(19.0760, 72.8777),
              zoom: 12,
            ),
            onMapCreated: (controller) => mapController = controller,
            markers: markers,
            polylines: polylines,
            onTap: _onMapTap,
            myLocationEnabled: true,
          ),

          /// Distance card
          if (distanceKm > 0)
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  "Distance: ${distanceKm.toStringAsFixed(2)} km",
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
