part of 'login_cubit.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final UserRole role;

  const LoginSuccess({required this.role});

  @override
  List<Object?> get props => [role];
}

final class LoginFailure extends LoginState {
  const LoginFailure({this.failure, this.suppressSnackbar = false});

  final GlobalFailure? failure;
  final bool suppressSnackbar;

  @override
  List<Object?> get props => [failure, suppressSnackbar];
}

final class LoginNetworkError extends LoginState {
  const LoginNetworkError({this.failure, this.suppressSnackbar = false});

  final GlobalFailure? failure;
  final bool suppressSnackbar;

  @override
  List<Object?> get props => [failure, suppressSnackbar];
}
