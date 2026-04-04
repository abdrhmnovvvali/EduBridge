part of 'teacher_create_task_cubit.dart';

enum TeacherCreateTaskStatus {
  idle,
  submitting,
  success,
  taskCreatedFileUploadFailed,
}

final class TeacherCreateTaskState extends Equatable {
  const TeacherCreateTaskState({
    this.selectedClass,
    this.dueDate,
    this.pickedFilePath,
    this.pickedFileName,
    this.status = TeacherCreateTaskStatus.idle,
    this.failure,
  });

  final TeacherClassResponse? selectedClass;
  final DateTime? dueDate;
  final String? pickedFilePath;
  final String? pickedFileName;
  final TeacherCreateTaskStatus status;
  final GlobalFailure? failure;

  bool get isSubmitting => status == TeacherCreateTaskStatus.submitting;

  TeacherCreateTaskState copyWith({
    TeacherClassResponse? selectedClass,
    DateTime? dueDate,
    String? pickedFilePath,
    String? pickedFileName,
    TeacherCreateTaskStatus? status,
    GlobalFailure? failure,
    bool clearFailure = false,
    bool clearPickedFile = false,
    bool clearDueDate = false,
  }) {
    return TeacherCreateTaskState(
      selectedClass: selectedClass ?? this.selectedClass,
      dueDate: clearDueDate ? null : (dueDate ?? this.dueDate),
      pickedFilePath: clearPickedFile ? null : (pickedFilePath ?? this.pickedFilePath),
      pickedFileName: clearPickedFile ? null : (pickedFileName ?? this.pickedFileName),
      status: status ?? this.status,
      failure: clearFailure ? null : (failure ?? this.failure),
    );
  }

  @override
  List<Object?> get props => [
        selectedClass,
        dueDate,
        pickedFilePath,
        pickedFileName,
        status,
        failure,
      ];
}
