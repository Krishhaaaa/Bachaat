import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

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

  void _onMapTap(LatLng position) {
    setState(() {
      if (pickup == null) {
        pickup = position;
      } else if (destination == null) {
        destination = position;
        _drawRoute();
      }

      markers.clear();

      if (pickup != null) {
        markers.add(
          Marker(
            markerId: const MarkerId("pickup"),
            position: pickup!,
            infoWindow: const InfoWindow(title: "Pickup"),
          ),
        );
      }

      if (destination != null) {
        markers.add(
          Marker(
            markerId: const MarkerId("destination"),
            position: destination!,
            infoWindow: const InfoWindow(title: "Destination"),
          ),
        );
      }
    });
  }

  void _drawRoute() {
    if (pickup == null || destination == null) return;

    polylines.clear();

    polylines.add(
      Polyline(
        polylineId: const PolylineId("route"),
        points: [pickup!, destination!],
        width: 5,
        color: Colors.blue,
      ),
    );

    _calculateDistance();
  }

  void _calculateDistance() {
    if (pickup == null || destination == null) return;

    double meters = Geolocator.distanceBetween(
      pickup!.latitude,
      pickup!.longitude,
      destination!.latitude,
      destination!.longitude,
    );

    distanceKm = meters / 1000;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Route")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            pickup = null;
            destination = null;
            markers.clear();
            polylines.clear();
            distanceKm = 0;
          });
        },
        child: const Icon(Icons.refresh),
      ),
      body: Stack(
        children: [
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

          if (distanceKm > 0)
            Positioned(
              bottom: 120,
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

          if (distanceKm > 0)
            Positioned(
              bottom: 40,
              left: 20,
              right: 20,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, distanceKm);
                  print(
                    "Returning distance: $distanceKm",
                  ); // 🔥 RETURN DISTANCE
                },
                child: const Text("Confirm Route"),
              ),
            ),
        ],
      ),
    );
  }
}
