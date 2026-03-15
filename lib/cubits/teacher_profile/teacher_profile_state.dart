part of 'teacher_profile_cubit.dart';

sealed class TeacherProfileState extends Equatable {
  const TeacherProfileState();

  @override
  List<Object> get props => [];
}

final class TeacherProfileInitial extends TeacherProfileState {}
final class TeacherProfileLoading extends TeacherProfileState {}
final class TeacherProfileSuccess extends TeacherProfileState {
   const TeacherProfileSuccess({required this.data});

  final TeacherProfileResponse data;

  @override
  List<Object> get props => [data];
}
final class TeacherProfileError extends TeacherProfileState {
  const TeacherProfileError({required this.failure});
  
  final GlobalFailure failure;

  @override
  List<Object> get props => [failure];
}
final class TeacherProfileNetworkError extends TeacherProfileState {
   const TeacherProfileNetworkError({required this.failure});
  
  final GlobalFailure failure;

  @override
  List<Object> get props => [failure];
}
