part of 'teacher_create_session_cubit.dart';

sealed class TeacherCreateSessionState extends Equatable {
  const TeacherCreateSessionState();
  @override
  List<Object?> get props => [];
}

final class TeacherCreateSessionInitial extends TeacherCreateSessionState {}
final class TeacherCreateSessionCreating extends TeacherCreateSessionState {}
final class TeacherCreateSessionSuccess extends TeacherCreateSessionState {
  const TeacherCreateSessionSuccess(this.session);
  final TeacherSessionResponse session;
  @override
  List<Object?> get props => [session];
}
final class TeacherCreateSessionError extends TeacherCreateSessionState {
  const TeacherCreateSessionError({required this.failure});
  final GlobalFailure failure;
  @override
  List<Object?> get props => [failure];
}
