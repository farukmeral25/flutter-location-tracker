import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:marti_case/core/common/either.dart';
import 'package:marti_case/core/error/failure.dart';
import 'package:marti_case/core/error/general_failures.dart';
import 'package:marti_case/core/utils/local_service/domain/param/local_key_param.dart';
import 'package:marti_case/core/utils/local_service/domain/param/local_key_with_value_param.dart';
import 'package:marti_case/core/utils/local_service/domain/repo/i_local_repo.dart';

class LocalRepo implements ILocalRepo {
  final FlutterSecureStorage secureStorage;

  LocalRepo({required this.secureStorage});

  @override
  Future<Either<Failure, String>> getDataFromKey(LocalKeyParam param) async {
    try {
      String? value = await secureStorage.read(key: param.key.value);
      if (value != null) {
        return Right(value);
      } else {
        return Left(NullPointerFailure(errorText: "Error: value is null"));
      }
    } catch (e) {
      return Left(ServiceFailure(errorText: "Error : $e"));
    }
  }

  @override
  Future<Either<Failure, void>> removeDataFromKey(LocalKeyParam param) async {
    try {
      await secureStorage.delete(key: param.key.value);
      return const Right(null);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, void>> saveDataFromKey(LocalKeyWithValueParam param) async {
    try {
      await secureStorage.write(key: param.key.value, value: param.value);
      return const Right(null);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
}
