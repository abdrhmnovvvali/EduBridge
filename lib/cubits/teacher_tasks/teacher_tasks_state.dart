part of 'teacher_tasks_cubit.dart';

sealed class TeacherTasksState extends Equatable {
  const TeacherTasksState();
  @override
  List<Object?> get props => [];
}

final class TeacherTasksInitial extends TeacherTasksState {}
final class TeacherTasksLoading extends TeacherTasksState {}
final class TeacherTasksCreating extends TeacherTasksState {}
final class TeacherTasksSuccess extends TeacherTasksState {
  const TeacherTasksSuccess(this.tasks);
  final List<TaskResponse> tasks;
  @override
  List<Object?> get props => [tasks];
}
final class TeacherTasksError extends TeacherTasksState {
  const TeacherTasksError({required this.failure});
  final GlobalFailure failure;
  @override
  List<Object?> get props => [failure];
}
