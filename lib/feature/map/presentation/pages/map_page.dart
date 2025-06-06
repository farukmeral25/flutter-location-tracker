import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:marti_case/core/init/injection_container.dart';
import 'package:marti_case/core/shared/app_scaffold.dart';
import 'package:marti_case/feature/map/presentation/bloc/cubit/map_cubit.dart';
import 'package:marti_case/feature/map/presentation/bloc/state/map_state.dart';
import 'package:marti_case/feature/map/presentation/widgets/map_app_bar.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = sl<MapCubit>();
    return BlocBuilder<MapCubit, MapState>(
      bloc: cubit,
      builder:
          (context, state) => AppScaffold(
            appBar: MapAppBar(),
            body: GoogleMap(
              initialCameraPosition: state.cameraPosition,
              onMapCreated: (GoogleMapController controller) => cubit.initializeController(controller),
              markers:
                  state.markers
                      .map((marker) => Marker(markerId: MarkerId(marker.id), position: LatLng(marker.lat, marker.lng), onTap: marker.onTap))
                      .toSet(),
              polylines: state.polylines,
              mapType: MapType.hybrid,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              compassEnabled: false,
              zoomControlsEnabled: true,
              trafficEnabled: false,
              buildingsEnabled: false,
              indoorViewEnabled: false,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => cubit.toggleLocationStream(),
              child: Visibility(visible: state.isActiveLocationStream, replacement: Icon(Icons.location_off), child: const Icon(Icons.location_on)),
            ),
          ),
    );
  }
}
