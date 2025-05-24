import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:marti_case/core/extensions/location_permission_extension.dart';
import 'package:marti_case/core/shared/app_snackbar.dart';

class AppPermissionHandler {
  static Future<void> requestLocationPermission() async {
    final permissionGranted = await Geolocator.requestPermission();

    if (permissionGranted.isDenied) {
      AppSnackbar(title: "Konum İzinleri Reddedildi", description: "Konum izinlerini vermeniz gerekiyor. Lütfen ayarlardan izinleri verin.").show();
    }
    if (permissionGranted.isWhileInUse) {
      AppSnackbar(
        title: "Konum izni verildi",
        description: "Arka planda konum izni için ayarlara gidiniz",
        action: SnackBarAction(
          label: "Ayarlar",
          onPressed: () {
            Geolocator.openAppSettings();
          },
        ),
      ).show();
    }
  }
}
