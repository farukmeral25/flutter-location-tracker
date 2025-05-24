import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:marti_case/core/shared/app_snackbar.dart';

part 'marker_dto.freezed.dart';

@freezed
class MarkerDto with _$MarkerDto {
  const factory MarkerDto({required String id, required double lat, required double lng}) = _MarkerDto;

  const MarkerDto._();

  Future<void> onTap() async {
    final placemarks = await placemarkFromCoordinates(lat, lng);

    if (placemarks.isNotEmpty) {
      final place = placemarks.first;
      AppSnackbar(title: "Tıklanan Konum", description: "${place.street}, ${place.locality}, ${place.country}").show();
    }
  }
}
