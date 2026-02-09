import 'package:todo/i18n/strings.g.dart';

abstract class Failure {
  final String message;
  const Failure(this.message);
  @override
  String toString() {
    return message;
  }
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
  UnknownFailure() : super(t.undefined);
}