import 'package:marti_case/core/common/either.dart';
import 'package:marti_case/core/error/failure.dart';
import 'package:marti_case/core/utils/local_service/domain/param/local_key_param.dart';
import 'package:marti_case/core/utils/local_service/domain/param/local_key_with_value_param.dart';

abstract class ILocalRepo {
  /// [LocalKeyParam] is a class that contains the key value to be used in the local service.
  /// GetDataFromKey method is used to get data from local service.
  Future<Either<Failure, String>> getDataFromKey(LocalKeyParam param);

  /// [LocalKeyWithValueParam] is a class that contains the key value and the value to be used in the local service.
  /// Remove Data From Key method is used to remove data from local service.
  Future<Either<Failure, void>> removeDataFromKey(LocalKeyParam param);

  /// [LocalKeyWithValueParam] is a class that contains the key value and the value to be used in the local service.
  /// SaveDateFromKey method is used to save data to local service.
  Future<Either<Failure, void>> saveDataFromKey(LocalKeyWithValueParam param);
}
