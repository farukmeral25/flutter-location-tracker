import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:marti_case/core/init/injection_container.dart';
import 'package:marti_case/core/shared/app_snackbar.dart';
import 'package:marti_case/feature/map/data/dto/marker_dto.dart';
import 'package:marti_case/feature/map/presentation/bloc/cubit/map_cubit.dart';

class LocationManager {
  static final LocationManager _instance = LocationManager._init();
  LocationManager._init();

  factory LocationManager() {
    return _instance;
  }

  StreamSubscription<Position>? _locationSubscription;

  /// Konum dinlemeyi başlatır
  void startLocationUpdates() async {
    _locationSubscription ??= Geolocator.getPositionStream(
      //TODO: distanceFilter will be 100 meters in production
      locationSettings: const LocationSettings(distanceFilter: 0, accuracy: LocationAccuracy.high),
    ).listen(
      (Position position) {
        print("Position: ${position.latitude}, ${position.longitude}");

        sl<MapCubit>().addMarker(MarkerDto(id: position.timestamp.toIso8601String(), lat: position.latitude, lng: position.longitude));
      },
      onError: (error) {
        AppSnackbar(title: "Konum dinlenirken hata oluştu.", description: "Konum izinlerini kontrol edin.").show();
      },
    );
  }

  /// Konum dinlemeyi durdurur
  void stopLocationUpdates() async {
    await _locationSubscription?.cancel();
    _locationSubscription = null;
  }
}
