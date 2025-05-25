import 'package:flutter/material.dart';
import 'package:marti_case/app.dart';
import 'package:marti_case/core/init/injection_container.dart' as locator;

void main() async {
  await locator.init();
  runApp(const LocationTrackerApp());
}
