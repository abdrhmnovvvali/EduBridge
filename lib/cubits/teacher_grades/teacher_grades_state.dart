part of 'teacher_grades_cubit.dart';

sealed class TeacherGradesState extends Equatable {
  const TeacherGradesState();
  @override
  List<Object?> get props => [];
}

final class TeacherGradesInitial extends TeacherGradesState {}
final class TeacherGradesSubmitting extends TeacherGradesState {}
final class TeacherGradesSuccess extends TeacherGradesState {}
final class TeacherGradesError extends TeacherGradesState {
  const TeacherGradesError({required this.failure});
  final GlobalFailure failure;
  @override
  List<Object?> get props => [failure];
}
