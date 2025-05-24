import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: const CameraPosition(target: LatLng(37.7749, -122.4194), zoom: 10),
      mapType: MapType.normal,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      compassEnabled: true,
      zoomControlsEnabled: true,
      trafficEnabled: true,
      buildingsEnabled: true,
      indoorViewEnabled: true,
    );
  }
}
