import 'package:flutter/material.dart';
import 'package:marti_case/feature/map/presentation/pages/map_page.dart';

class AppPageRoutes {
  static const String map = '/map';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case map:
        return MaterialPageRoute(builder: (_) => const MapPage(), settings: settings);
      default:
        return MaterialPageRoute(builder: (_) => const MapPage(), settings: settings);
    }
  }
}
