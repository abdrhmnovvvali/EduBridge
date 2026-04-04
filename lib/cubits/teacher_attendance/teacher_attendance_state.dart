part of 'teacher_attendance_cubit.dart';

sealed class TeacherAttendanceState extends Equatable {
  const TeacherAttendanceState();
  @override
  List<Object?> get props => [];
}

final class TeacherAttendanceInitial extends TeacherAttendanceState {}
final class TeacherAttendanceSubmitting extends TeacherAttendanceState {}
final class TeacherAttendanceSuccess extends TeacherAttendanceState {}
final class TeacherAttendanceError extends TeacherAttendanceState {
  const TeacherAttendanceError({required this.failure});
  final GlobalFailure failure;
  @override
  List<Object?> get props => [failure];
}
