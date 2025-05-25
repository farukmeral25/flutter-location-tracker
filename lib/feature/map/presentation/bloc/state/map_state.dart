import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:marti_case/feature/map/data/dto/marker_dto.dart';

part 'map_state.freezed.dart';

@freezed
class MapState with _$MapState {
  const factory MapState({
    GoogleMapController? controller,
    @Default([]) List<MarkerDto> markers,
    @Default({}) Set<Polyline> polylines,
    @Default(true) bool isActiveLocationStream,
  }) = _MapState;
}
