part of 'student_profile_cubit.dart';

sealed class StudentProfileState extends Equatable {
  const StudentProfileState();

  @override
  List<Object> get props => [];
}

final class StudentProfileInitial extends StudentProfileState {}
final class StudentProfileLoading extends StudentProfileState {}
final class StudentProfileSuccess extends StudentProfileState {
   const StudentProfileSuccess({required this.data});

  final StudentProfileResponse data;

  @override
  List<Object> get props => [data];
}
final class StudentProfileError extends StudentProfileState {
  const StudentProfileError({required this.failure});
  
  final GlobalFailure failure;

  @override
  List<Object> get props => [failure];
}
final class StudentProfileNetworkError extends StudentProfileState {
   const StudentProfileNetworkError({required this.failure});
  
  final GlobalFailure failure;

  @override
  List<Object> get props => [failure];
}
