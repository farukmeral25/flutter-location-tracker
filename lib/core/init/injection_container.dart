import 'package:get_it/get_it.dart';
import 'package:marti_case/feature/map/presentation/bloc/cubit/map_cubit.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory<MapCubit>(() => MapCubit()..initialize());
}
