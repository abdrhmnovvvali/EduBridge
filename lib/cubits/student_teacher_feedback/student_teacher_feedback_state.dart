part of 'student_teacher_feedback_cubit.dart';

class StudentTeacherFeedbackState extends Equatable {
  const StudentTeacherFeedbackState({
    this.items = const [],
    this.page = 1,
    this.totalPages = 1,
    this.total = 0,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.failure,
    this.enrollments = const [],
    this.selectedClassId,
  });

  final List<StudentTeacherFeedbackItem> items;
  final int page;
  final int totalPages;
  final int total;
  final bool isLoading;
  final bool isLoadingMore;
  final GlobalFailure? failure;
  final List<Enrollment> enrollments;
  final int? selectedClassId;

  bool get hasMore => page < totalPages;

  StudentTeacherFeedbackState copyWith({
    List<StudentTeacherFeedbackItem>? items,
    int? page,
    int? totalPages,
    int? total,
    bool? isLoading,
    bool? isLoadingMore,
    GlobalFailure? failure,
    bool clearFailure = false,
    List<Enrollment>? enrollments,
    int? selectedClassId,
    bool clearSelectedClass = false,
  }) {
    return StudentTeacherFeedbackState(
      items: items ?? this.items,
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
      total: total ?? this.total,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      failure: clearFailure ? null : (failure ?? this.failure),
      enrollments: enrollments ?? this.enrollments,
      selectedClassId: clearSelectedClass ? null : (selectedClassId ?? this.selectedClassId),
    );
  }

  @override
  List<Object?> get props =>
      [items, page, totalPages, total, isLoading, isLoadingMore, failure, enrollments, selectedClassId];
}
