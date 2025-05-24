import 'package:flutter/material.dart';
import 'package:marti_case/core/init/injection_container.dart' as locator;
import 'package:marti_case/core/keys/app_keys.dart';
import 'package:marti_case/feature/map/presentation/pages/map_page.dart';

void main() async {
  await locator.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MapPage(), scaffoldMessengerKey: AppKeys.scaffoldMessengerKey, navigatorKey: AppKeys.navigatorKey);
  }
}
