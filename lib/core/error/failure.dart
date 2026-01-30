import 'package:todo/core/constants/app_constants.dart';

abstract class Failure {
  final String message;
  const Failure(this.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

class AuthFailure extends Failure {
  const AuthFailure(super.message);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message);
}

class UnknownFailure extends Failure {
  const UnknownFailure() : super(AppConstants.UNDEFINED);
}