part of 'teacher_class_sessions_cubit.dart';

sealed class TeacherClassSessionsState extends Equatable {
  const TeacherClassSessionsState();
  @override
  List<Object?> get props => [];
}

final class TeacherClassSessionsInitial extends TeacherClassSessionsState {}
final class TeacherClassSessionsLoading extends TeacherClassSessionsState {}
final class TeacherClassSessionsSuccess extends TeacherClassSessionsState {
  const TeacherClassSessionsSuccess(this.sessions);
  final List<TeacherSessionResponse> sessions;
  @override
  List<Object?> get props => [sessions];
}
final class TeacherClassSessionsError extends TeacherClassSessionsState {
  const TeacherClassSessionsError({required this.failure});
  final GlobalFailure failure;
  @override
  List<Object?> get props => [failure];
}
