import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:marti_case/core/utils/app_permission_handler.dart';
import 'package:marti_case/core/utils/location_manager.dart';
import 'package:marti_case/feature/map/data/dto/marker_dto.dart';
import 'package:marti_case/feature/map/domain/repo/i_map_repo.dart';
import 'package:marti_case/feature/map/presentation/bloc/state/map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit({required IMapRepo mapRepo}) : _mapRepo = mapRepo, super(const MapState());

  final IMapRepo _mapRepo;

  Future<void> initialize() async {
    await AppPermissionHandler.requestLocationPermission();
    await _loadMap();
    LocationManager().startLocationUpdates();
  }

  void initializeController(GoogleMapController controller) {
    emit(state.copyWith(controller: controller));
  }

  void toggleLocationStream() {
    if (state.isActiveLocationStream) {
      LocationManager().stopLocationUpdates();
    } else {
      LocationManager().startLocationUpdates();
    }
    emit(state.copyWith(isActiveLocationStream: !state.isActiveLocationStream));
  }

  Future<void> _loadMap() async {
    final getMarkersEither = await _mapRepo.getMarkers();
    getMarkersEither.fold(
      (failure) {
        emit(state.copyWith(markers: []));
      },
      (markers) {
        emit(state.copyWith(markers: markers));
      },
    );
  }

  Future<void> addMarker(MarkerDto marker) async {
    final updatedMarkers = List<MarkerDto>.from(state.markers)..add(marker);
    emit(state.copyWith(markers: updatedMarkers));
    _mapRepo.saveMarkers(updatedMarkers);
  }

  void refreshRoute() {
    emit(state.copyWith(points: [], markers: []));
    _mapRepo.saveMarkers([]);
  }
}
