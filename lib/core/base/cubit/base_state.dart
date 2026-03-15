part of 'base_cubit.dart';

@immutable
sealed class BaseState<T> extends Equatable {
  const BaseState();

  @override
  List<Object?> get props => [];
}

final class Initial<T> extends BaseState<T> {}

final class Loading<T> extends BaseState<T> {}

final class Success<T> extends BaseState<T> {}

final class Failure<T> extends BaseState<T> {
  const Failure({this.message = "An error occurred"}) : _failure = const GlobalFailure.server();

  final GlobalFailure? _failure;
  final String message;

  @override
  List<Object?> get props => [_failure];
}

final class NetworkFailure<T> extends BaseState<T> {
  const NetworkFailure() : _failure = const GlobalFailure.network();

  final GlobalFailure? _failure;

  @override
  List<Object?> get props => [_failure];
}
