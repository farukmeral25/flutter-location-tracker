import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:marti_case/core/utils/local_service/data/repo/local_repo.dart';
import 'package:marti_case/core/utils/local_service/domain/repo/i_local_repo.dart';
import 'package:marti_case/feature/map/data/repo/map_repo.dart';
import 'package:marti_case/feature/map/domain/repo/i_map_repo.dart';
import 'package:marti_case/feature/map/presentation/bloc/cubit/map_cubit.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<FlutterSecureStorage>(() => const FlutterSecureStorage());

  sl.registerLazySingleton<ILocalRepo>(() => LocalRepo(secureStorage: sl()));
  sl.registerLazySingleton<IMapRepo>(() => MapRepo(localRepo: sl()));

  sl.registerLazySingleton<MapCubit>(() => MapCubit(mapRepo: sl())..initialize());
}
