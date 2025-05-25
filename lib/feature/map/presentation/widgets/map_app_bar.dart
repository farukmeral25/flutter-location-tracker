import 'package:flutter/material.dart';
import 'package:marti_case/core/constants/app_constants.dart';
import 'package:marti_case/core/init/injection_container.dart';
import 'package:marti_case/feature/map/presentation/bloc/cubit/map_cubit.dart';

class MapAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MapAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(AppConstants.appName),
      actions: [IconButton(icon: const Icon(Icons.refresh_sharp), onPressed: sl<MapCubit>().refreshRoute)],
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
