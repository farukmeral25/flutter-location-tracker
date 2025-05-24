import 'dart:convert';

import 'package:marti_case/core/common/either.dart';
import 'package:marti_case/core/error/failure.dart';
import 'package:marti_case/core/utils/local_service/domain/enum/local_keys.dart';
import 'package:marti_case/core/utils/local_service/domain/param/local_key_param.dart';
import 'package:marti_case/core/utils/local_service/domain/param/local_key_with_value_param.dart';
import 'package:marti_case/core/utils/local_service/domain/repo/i_local_repo.dart';
import 'package:marti_case/feature/map/data/dto/marker_dto.dart';
import 'package:marti_case/feature/map/domain/repo/i_map_repo.dart';

class MapRepo implements IMapRepo {
  final ILocalRepo _localRepo;

  MapRepo({required ILocalRepo localRepo}) : _localRepo = localRepo;
  @override
  Future<Either<Failure, List<MarkerDto>>> getMarkers() async {
    final getMarkersEither = await _localRepo.getDataFromKey(LocalKeyParam(key: LocalKeys.userRoute));
    return getMarkersEither.fold(
      (failure) {
        return Left(failure);
      },
      (data) {
        final List<dynamic> dynamicList = json.decode(data);
        final markers = dynamicList.map((e) => MarkerDto.fromJson(e)).toList();
        return Right(markers);
      },
    );
  }

  @override
  Future<void> saveMarkers(List<MarkerDto> markers) async {
    final markersJsonList = markers.map((marker) => marker.toJson()).toList();

    _localRepo.saveDataFromKey(LocalKeyWithValueParam(key: LocalKeys.userRoute, value: json.encode(markersJsonList)));
  }
}
