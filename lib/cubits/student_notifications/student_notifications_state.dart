part of 'student_notifications_cubit.dart';

sealed class StudentNotificationsState extends Equatable {
  const StudentNotificationsState();
  @override
  List<Object?> get props => [];
}

final class StudentNotificationsInitial extends StudentNotificationsState {}
final class StudentNotificationsLoading extends StudentNotificationsState {}
final class StudentNotificationsSuccess extends StudentNotificationsState {
  const StudentNotificationsSuccess(this.notifications);
  final List<NotificationResponse> notifications;
  @override
  List<Object?> get props => [notifications];
}
final class StudentNotificationsError extends StudentNotificationsState {
  const StudentNotificationsError({required this.failure});
  final GlobalFailure failure;
  @override
  List<Object?> get props => [failure];
}
