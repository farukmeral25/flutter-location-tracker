import 'package:marti_case/core/error/failure.dart';

class ServiceFailure extends Failure {
  ServiceFailure({required super.errorText});
}

class NullPointerFailure extends Failure {
  NullPointerFailure({required super.errorText});
}
