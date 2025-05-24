import 'package:marti_case/core/shared/app_snackbar.dart';

class Failure {
  final String errorText;

  Failure({required this.errorText});
}

extension FailureExtension on Failure {
  void showSnackBar() {
    AppSnackbar(title: "Failure", description: errorText).show();
  }
}
