import 'package:flutter/material.dart';
import 'package:marti_case/core/keys/app_keys.dart';

class AppSnackbar extends SnackBar {
  AppSnackbar({super.key, super.action, required String title, required String description})
    : super(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 4,
          children: [Text(title, style: const TextStyle(fontWeight: FontWeight.bold)), Text(description)],
        ),
        duration: const Duration(seconds: 3),

        behavior: SnackBarBehavior.floating,
      );

  void show() {
    AppKeys.scaffoldMessengerKey.currentState?.showSnackBar(this);
  }
}
