part of 'teacher_classes_cubit.dart';

sealed class TeacherClassesState extends Equatable {
  const TeacherClassesState();
  @override
  List<Object?> get props => [];
}

final class TeacherClassesInitial extends TeacherClassesState {}
final class TeacherClassesLoading extends TeacherClassesState {}
final class TeacherClassesSuccess extends TeacherClassesState {
  const TeacherClassesSuccess(this.classes);
  final List<TeacherClassResponse> classes;
  @override
  List<Object?> get props => [classes];
}
final class TeacherClassesError extends TeacherClassesState {
  const TeacherClassesError({required this.failure});
  final GlobalFailure failure;
  @override
  List<Object?> get props => [failure];
}
