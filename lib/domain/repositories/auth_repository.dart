import 'package:fpdart/fpdart.dart';
import 'package:todo/core/error/failure.dart';
import 'package:todo/domain/entities/user_entity.dart';

import '../../presentation/cubit/auth/auth_cubit.dart';



abstract class AuthRepository {

  Stream<AuthenticationStatus> get status;

  TaskEither<Failure, UserEntity> login(String id, String password);

  TaskEither<Failure, Map<String,dynamic>> signUp(String id, String password);

  AuthenticationStatus getInitialStatus();

  int? getUserId();

  Future<void> logOut();

  void dispose();
}