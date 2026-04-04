part of 'student_leaderboard_cubit.dart';

sealed class StudentLeaderboardState extends Equatable {
  const StudentLeaderboardState();
  @override
  List<Object?> get props => [];
}

final class StudentLeaderboardInitial extends StudentLeaderboardState {}
final class StudentLeaderboardLoading extends StudentLeaderboardState {}
final class StudentLeaderboardSuccess extends StudentLeaderboardState {
  const StudentLeaderboardSuccess(this.data);
  final LeaderboardResponse data;
  @override
  List<Object?> get props => [data];
}
final class StudentLeaderboardError extends StudentLeaderboardState {
  const StudentLeaderboardError({required this.failure});
  final GlobalFailure failure;
  @override
  List<Object?> get props => [failure];
}
