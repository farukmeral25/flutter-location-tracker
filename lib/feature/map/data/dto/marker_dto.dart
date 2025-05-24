import 'package:freezed_annotation/freezed_annotation.dart';

part 'marker_dto.freezed.dart';

@freezed
class MarkerDto with _$MarkerDto {
  const factory MarkerDto({required String markerId, required double lat, required double lng}) = _MarkerDto;
}
