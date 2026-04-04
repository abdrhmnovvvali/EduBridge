part of 'student_attendance_cubit.dart';

sealed class StudentAttendanceState extends Equatable {
  const StudentAttendanceState();
  @override
  List<Object?> get props => [];
}

final class StudentAttendanceInitial extends StudentAttendanceState {}
final class StudentAttendanceLoading extends StudentAttendanceState {}
final class StudentAttendanceSuccess extends StudentAttendanceState {
  const StudentAttendanceSuccess(this.items, {required this.absentCount});
  final List<AttendanceResponse> items;
  final int absentCount;
  @override
  List<Object?> get props => [items, absentCount];
}
final class StudentAttendanceError extends StudentAttendanceState {
  const StudentAttendanceError({required this.failure});
  final GlobalFailure failure;
  @override
  List<Object?> get props => [failure];
}
