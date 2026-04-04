part of 'student_tasks_cubit.dart';

sealed class StudentTasksState extends Equatable {
  const StudentTasksState();
  @override
  List<Object?> get props => [];
}

final class StudentTasksInitial extends StudentTasksState {}
final class StudentTasksLoading extends StudentTasksState {}
final class StudentTasksSuccess extends StudentTasksState {
  const StudentTasksSuccess(this.tasks);
  final List<TaskResponse> tasks;
  @override
  List<Object?> get props => [tasks];
}
final class StudentTasksError extends StudentTasksState {
  const StudentTasksError({required this.failure});
  final GlobalFailure failure;
  @override
  List<Object?> get props => [failure];
}
