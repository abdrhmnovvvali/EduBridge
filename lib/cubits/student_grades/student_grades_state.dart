part of 'student_grades_cubit.dart';

sealed class StudentGradesState extends Equatable {
  const StudentGradesState();
  @override
  List<Object?> get props => [];
}

final class StudentGradesInitial extends StudentGradesState {}
final class StudentGradesLoading extends StudentGradesState {}
final class StudentGradesSuccess extends StudentGradesState {
  const StudentGradesSuccess(this.grades);
  final List<GradeResponse> grades;
  @override
  List<Object?> get props => [grades];
}
final class StudentGradesError extends StudentGradesState {
  const StudentGradesError({required this.failure});
  final GlobalFailure failure;
  @override
  List<Object?> get props => [failure];
}
