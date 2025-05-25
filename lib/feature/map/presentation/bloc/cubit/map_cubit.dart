import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:marti_case/core/constants/app_strings.dart';
import 'package:marti_case/core/shared/app_snackbar.dart';
import 'package:marti_case/core/utils/app_permission_handler.dart';
import 'package:marti_case/core/utils/location_manager.dart';
import 'package:marti_case/feature/map/data/dto/marker_dto.dart';
import 'package:marti_case/feature/map/domain/repo/i_map_repo.dart';
import 'package:marti_case/feature/map/presentation/bloc/state/map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit({required IMapRepo mapRepo}) : _mapRepo = mapRepo, super(const MapState());

  final IMapRepo _mapRepo;

  final polyline = Polyline(polylineId: const PolylineId("my_route"), points: []);

  Future<void> initialize() async {
    await AppPermissionHandler.requestLocationPermission();
    await setCurrentPosition();
    await _loadMap();
    LocationManager().startLocationUpdates();
  }

  void initializeController(GoogleMapController controller) {
    emit(state.copyWith(controller: controller));
  }

  void toggleLocationStream() {
    if (state.isActiveLocationStream) {
      LocationManager().stopLocationUpdates();
      AppSnackbar(title: AppStrings.locationTracking, description: AppStrings.locationTrackingStopped).show();
    } else {
      LocationManager().startLocationUpdates();
      AppSnackbar(title: AppStrings.locationTracking, description: AppStrings.locationTrackingStarted).show();
    }
    emit(state.copyWith(isActiveLocationStream: !state.isActiveLocationStream));
  }

  Future<void> _loadMap() async {
    final getMarkersEither = await _mapRepo.getMarkers();
    getMarkersEither.fold(
      (failure) {
        emit(state.copyWith(markers: [], polylines: {polyline.copyWith(pointsParam: [])}));
      },
      (markers) {
        emit(
          state.copyWith(
            markers: markers,
            polylines: {polyline.copyWith(pointsParam: markers.map((marker) => LatLng(marker.lat, marker.lng)).toList())},
          ),
        );
      },
    );
  }

  Future<void> addMarker(MarkerDto marker) async {
    final updatedMarkers = List<MarkerDto>.from(state.markers)..add(marker);
    emit(
      state.copyWith(
        markers: updatedMarkers,
        polylines: {polyline.copyWith(pointsParam: updatedMarkers.map((marker) => LatLng(marker.lat, marker.lng)).toList())},
      ),
    );
    _mapRepo.saveMarkers(updatedMarkers);
  }

  void refreshRoute() {
    emit(state.copyWith(polylines: {}, markers: []));
    _mapRepo.saveMarkers([]);
  }

  Future<void> setCurrentPosition() async {
    Position? position = await LocationManager().getPosition;

    if (position != null) {
      emit(state.copyWith(cameraPosition: CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: 10)));
    }
  }
}
