part of 'teacher_task_submissions_cubit.dart';

sealed class TeacherTaskSubmissionsState extends Equatable {
  const TeacherTaskSubmissionsState();
  @override
  List<Object?> get props => [];
}

final class TeacherTaskSubmissionsInitial extends TeacherTaskSubmissionsState {}
final class TeacherTaskSubmissionsLoading extends TeacherTaskSubmissionsState {}
final class TeacherTaskSubmissionsSuccess extends TeacherTaskSubmissionsState {
  const TeacherTaskSubmissionsSuccess(this.submissions, {required this.taskId});
  final List<TeacherTaskSubmissionResponse> submissions;
  final int taskId;
  @override
  List<Object?> get props => [submissions, taskId];
}
final class TeacherTaskSubmissionsError extends TeacherTaskSubmissionsState {
  const TeacherTaskSubmissionsError({required this.failure});
  final GlobalFailure failure;
  @override
  List<Object?> get props => [failure];
}
