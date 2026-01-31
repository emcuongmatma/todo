import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo/core/constants/key.dart';
import 'package:todo/core/error/failure.dart';
import 'package:todo/domain/repositories/auth_repository.dart';
import 'package:todo/presentation/models/normal_input.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthRepository authRepository;
  StreamSubscription? _getAuthStatus;

  AuthCubit({required this.authRepository}) : super(const AuthState());

  void init() {
    if (_getAuthStatus != null) return;
    _getAuthStatus = authRepository.status.listen(
      (status) {
        emit(state.copyWith(status: status));
      },
      onError: (error) {
        emit(state.copyWith(status: AuthenticationStatus.unknown));
      },
    );
  }

  void onUsernameChange({
    required String username,
    required bool validConfirmPassword,
  }) {
    debugPrint(username);
    final usernameInput = NormalInput.dirty(username);
    final confirmValid = validConfirmPassword
        ? state.confirmPasswordInput.value == state.passwordInput.value &&
              state.confirmPasswordInput.isValid
        : true;
    emit(
      state.copyWith(
        usernameInput: usernameInput,
        isValid:
            usernameInput.isValid &&
            state.passwordInput.isValid &&
            confirmValid,
      ),
    );
  }

  void onPasswordChange({
    required String password,
    required bool validConfirmPassword,
  }) {
    final passwordInput = NormalInput.dirty(password);
    final confirmValid = validConfirmPassword
        ? state.confirmPasswordInput.value == passwordInput.value &&
              state.confirmPasswordInput.isValid
        : true;
    emit(
      state.copyWith(
        passwordInput: passwordInput,
        isValid:
            passwordInput.isValid &&
            state.usernameInput.isValid &&
            confirmValid,
      ),
    );
  }

  void onConfirmPasswordChange({
    required String confirmPassword,
    required bool validConfirmPassword,
  }) {
    final confirmPasswordInput = NormalInput.dirty(confirmPassword);
    final confirmValid = validConfirmPassword
        ? state.passwordInput.value == confirmPasswordInput.value
        : true;
    emit(
      state.copyWith(
        confirmPasswordInput: confirmPasswordInput,
        isValid:
            confirmPasswordInput.isValid &&
            state.usernameInput.isValid &&
            state.passwordInput.isValid &&
            confirmValid,
      ),
    );
  }

  Future<void> login() async {
    emit(state.copyWith(isLoading: true));
    final result = await authRepository
        .login(state.usernameInput.value, state.passwordInput.value)
        .run();
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: AuthenticationStatus.unauthenticated,
            isLoading: false,
            effect: AuthScreenEffect.error,
            error: failure,
          ),
        );
      },
      (user) => emit(
        state.copyWith(
          status: AuthenticationStatus.authenticated,
          effect: AuthScreenEffect.success,
          isLoading: false,
        ),
      ),
    );
  }

  Future<void> signUp() async {
    emit(state.copyWith(isLoading: true));
    final result = await authRepository
        .signUp(state.usernameInput.value, state.passwordInput.value)
        .run();
    result.fold(
      (failure) {
        debugPrint(failure.message);
        emit(
          state.copyWith(
            status: AuthenticationStatus.unauthenticated,
            isLoading: false,
            effect: AuthScreenEffect.error,
            error: failure,
          ),
        );
      },
      (user) {
        if (user.containsKey(AppKey.ID)) {
          emit(
            state.copyWith(effect: AuthScreenEffect.success, isLoading: false),
          );
        }
      },
    );
  }

  void clearEffect() {
    emit(state.copyWith(effect: AuthScreenEffect.none));
  }

  @override
  Future<void> close() {
    _getAuthStatus?.cancel();
    return super.close();
  }
}
