import 'package:flutter/material.dart';
import 'package:marti_case/core/keys/app_keys.dart';
import 'package:marti_case/core/utils/routes/app_page_routes.dart';

class LocationTrackerApp extends StatelessWidget {
  const LocationTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: AppKeys.navigatorKey,
      scaffoldMessengerKey: AppKeys.scaffoldMessengerKey,
      onGenerateRoute: AppPageRoutes.generateRoute,
    );
  }
}
