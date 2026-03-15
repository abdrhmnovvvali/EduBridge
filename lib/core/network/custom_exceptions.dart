import 'package:equatable/equatable.dart';

abstract class CustomException extends Equatable implements Exception {
  final String message;

  const CustomException(this.message);

  @override
  List<Object?> get props => [message];

  @override
  bool? get stringify => true;

  @override
  String toString() => '$runtimeType: $message';
}

class CancelGoogleSignInException extends CustomException {
  const CancelGoogleSignInException(super.message);
}

class ServerException extends CustomException {
  const ServerException(super.message);
}

class CancelTokenException extends CustomException {
  const CancelTokenException(super.message);
}
