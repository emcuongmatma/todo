part of 'auth_cubit.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

enum AuthScreenEffect { none, error, success }

class AuthState extends Equatable {
  final AuthenticationStatus status;
  final NormalInput usernameInput;
  final NormalInput passwordInput;
  final NormalInput confirmPasswordInput;
  final bool isLoading;
  final bool isValid;
  final AuthScreenEffect effect;
  final Failure? error;

  const AuthState({
    this.status = AuthenticationStatus.unauthenticated,
    this.usernameInput = const NormalInput.pure(),
    this.passwordInput = const NormalInput.pure(),
    this.isValid = false,
    this.effect = AuthScreenEffect.none,
    this.confirmPasswordInput = const NormalInput.pure(),
    this.isLoading = false,
    this.error
  });

  AuthState copyWith({
    AuthenticationStatus? status,
    String? username,
    String? password,
    bool? isValid,
    NormalInput? usernameInput,
    NormalInput? passwordInput,
    NormalInput? confirmPasswordInput,
    AuthScreenEffect? effect,
    bool? isLoading,
    Failure? error
  }) {
    return AuthState(
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      usernameInput: usernameInput ?? this.usernameInput,
      passwordInput: passwordInput ?? this.passwordInput,
      confirmPasswordInput: confirmPasswordInput ?? this.confirmPasswordInput,
      effect: effect ?? this.effect,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error
    );
  }

  @override
  List<Object> get props => [
    status,
    usernameInput,
    passwordInput,
    confirmPasswordInput,
    isValid,
    effect,
    isLoading,
    ?error
  ];
}
