part of 'teacher_class_students_cubit.dart';

sealed class TeacherClassStudentsState extends Equatable {
  const TeacherClassStudentsState();
  @override
  List<Object?> get props => [];
}

final class TeacherClassStudentsInitial extends TeacherClassStudentsState {}
final class TeacherClassStudentsLoading extends TeacherClassStudentsState {}
final class TeacherClassStudentsSuccess extends TeacherClassStudentsState {
  const TeacherClassStudentsSuccess(this.students);
  final List<TeacherClassStudentResponse> students;
  @override
  List<Object?> get props => [students];
}
final class TeacherClassStudentsError extends TeacherClassStudentsState {
  const TeacherClassStudentsError({required this.failure});
  final GlobalFailure failure;
  @override
  List<Object?> get props => [failure];
}
