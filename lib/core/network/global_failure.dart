import 'package:equatable/equatable.dart';

class GlobalFailure extends Equatable {
  const GlobalFailure(this.message);
  const GlobalFailure.server() : message = 'Something went wrong.';
  const GlobalFailure.network() : message = 'Network is not available.';

  final String? message;

  @override
  List<Object?> get props => [message];
}
