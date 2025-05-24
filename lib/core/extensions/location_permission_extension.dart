import 'package:geolocator/geolocator.dart';

extension LocationPermissionExtension on LocationPermission {
  bool get isDenied => this == LocationPermission.denied || this == LocationPermission.deniedForever;
  bool get isWhileInUse => this == LocationPermission.whileInUse;
}
