import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:marti_case/core/init/injection_container.dart';
import 'package:marti_case/core/shared/app_scaffold.dart';
import 'package:marti_case/feature/map/presenntation/bloc/cubit/map_cubit.dart';
import 'package:marti_case/feature/map/presenntation/bloc/state/map_state.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = sl<MapCubit>();
    return AppScaffold(
      appBar: AppBar(
        title: const Text("User Location Active"),
        actions: [IconButton(icon: const Icon(Icons.refresh_sharp), onPressed: cubit.refreshRoute)],
      ),
      body: BlocBuilder<MapCubit, MapState>(
        bloc: cubit,
        builder:
            (context, state) => GoogleMap(
              initialCameraPosition: const CameraPosition(target: LatLng(40.8793, 29.2581), zoom: 10),
              onMapCreated: (GoogleMapController controller) => cubit.initializeController(controller),
              markers:
                  state.markers
                      .map((marker) => Marker(markerId: MarkerId(marker.id), position: LatLng(marker.lat, marker.lng), onTap: marker.onTap))
                      .toSet(),
              polylines: {
                Polyline(polylineId: PolylineId("my_route"), points: [...state.points], color: Colors.blue),
              },
              mapType: MapType.normal,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              compassEnabled: true,
              zoomControlsEnabled: true,
              trafficEnabled: false,
              buildingsEnabled: false,
              indoorViewEnabled: true,
            ),
      ),
    );
  }
}
