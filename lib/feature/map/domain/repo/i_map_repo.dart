import 'package:marti_case/core/common/either.dart';
import 'package:marti_case/core/error/failure.dart';
import 'package:marti_case/feature/map/data/dto/marker_dto.dart';

abstract class IMapRepo {
  Future<Either<Failure, List<MarkerDto>>> getMarkers();
  Future<void> saveMarkers(List<MarkerDto> markers);
}
