import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:fpdart/fpdart.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todo/core/constants/key.dart';
import 'package:todo/core/error/failure.dart';
import 'package:todo/data/datasources/local/auth_local_data_source.dart';
import 'package:todo/data/datasources/remote/auth_remote_data_source.dart';
import 'package:todo/domain/entities/user_entity.dart';
import 'package:todo/domain/repositories/auth_repository.dart';
import 'package:todo/i18n/strings.g.dart';
import 'package:todo/presentation/cubit/auth/auth_cubit.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;
  final _controller = BehaviorSubject<AuthenticationStatus>();

  AuthRepositoryImpl({
    required this.authRemoteDataSource,
    required this.authLocalDataSource,
  });



  @override
  Stream<AuthenticationStatus> get status => _controller.asBroadcastStream();

  @override
  AuthenticationStatus getInitialStatus() {
    return getUserId() != null
        ? AuthenticationStatus.authenticated
        : AuthenticationStatus.unauthenticated;
  }

  @override
  TaskEither<Failure, UserEntity> login(String username, String password) {
    return TaskEither<Failure, List<dynamic>>.tryCatch(
          () async => await authRemoteDataSource.login(username),
          (error, _) {
        if (error is AuthFailure) return error;
        return NetworkFailure(error.toString());
      },
    ).flatMap((userDataList) {
      final userData = userDataList.first;
      if (userData.isEmpty) {
        return TaskEither.left(
          AuthFailure(t.error_username_not_found),
        );
      }
      debugPrint("loaded data");
      if (userData[AppKey.PASSWORD] == password) {
        return TaskEither.tryCatch(() async {
          debugPrint("save");
          await authLocalDataSource.saveUserData(
            int.parse(userData[AppKey.ID]),
            userData[AppKey.USER_AVATAR],
          );
          debugPrint("logined");
          _controller.add(AuthenticationStatus.authenticated);
          return UserEntity.fromJson(userData);
        }, (error, _) => DatabaseFailure(error.toString()));
      } else {
        _controller.add(AuthenticationStatus.unauthenticated);
        return TaskEither.left(
          AuthFailure(t.error_wrong_credentials),
        );
      }
    });
  }

  @override
  Future<void> logOut() async {
    await authLocalDataSource.clearSession();
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  @override
  void dispose() => _controller.close();

  @override
  TaskEither<Failure, Map<String, dynamic>> signUp(String username,
      String password,) {
    return TaskEither<Failure, Map<String, dynamic>>.tryCatch(
          () async => await authRemoteDataSource.signUp(username, password),
          (error, _) {
        if (error is AuthFailure) return error;
        return NetworkFailure(error.toString());
      },
    );
  }

  @override
  int? getUserId() => authLocalDataSource.getUserId();
}
