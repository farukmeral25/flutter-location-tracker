import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marti_case/feature/map/data/dto/marker_dto.dart';
import 'package:marti_case/feature/map/presenntation/bloc/state/map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(const MapState());

  Future<void> loadMap() async {
    //TODO: Fetch local to load map data

    emit(state.copyWith(markers: []));
  }

  Future<void> addMarker(MarkerDto marker) async {
    final updatedMarkers = List<MarkerDto>.from(state.markers)..add(marker);
    emit(state.copyWith(markers: updatedMarkers));
  }

  Future<void> removeMarker(MarkerDto marker) async {
    final updatedMarkers = List<MarkerDto>.from(state.markers)..remove(marker);
    emit(state.copyWith(markers: updatedMarkers));
  }

  Future<void> clearMarkers() async {
    emit(state.copyWith(markers: []));
  }
}
