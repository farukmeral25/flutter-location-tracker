import 'package:get_it/get_it.dart';
import 'package:marti_case/feature/map/presenntation/bloc/cubit/map_cubit.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<MapCubit>(() => MapCubit());
}
