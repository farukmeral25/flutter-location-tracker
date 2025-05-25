import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:marti_case/core/constants/app_strings.dart';
import 'package:marti_case/core/extensions/location_permission_extension.dart';
import 'package:marti_case/core/shared/app_snackbar.dart';

class AppPermissionHandler {
  static Future<void> requestLocationPermission() async {
    final permissionGranted = await Geolocator.requestPermission();

    if (permissionGranted.isDenied) {
      AppSnackbar(title: AppStrings.locationPermissionDenied, description: AppStrings.locationPermissionDeniedDescription).show();
    }
    if (permissionGranted.isWhileInUse) {
      AppSnackbar(
        title: AppStrings.locationPermissionGranted,
        description: AppStrings.locationPermissionGrantedDescription,
        action: SnackBarAction(
          label: AppStrings.locationPermissionSettingsAction,
          onPressed: () {
            Geolocator.openAppSettings();
          },
        ),
      ).show();
    }
  }
}
