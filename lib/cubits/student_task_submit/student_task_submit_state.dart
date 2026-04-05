part of 'student_task_submit_cubit.dart';

enum StudentTaskSubmitStatus { idle, submitting, success }

class StudentTaskSubmitState extends Equatable {
  const StudentTaskSubmitState({
    this.status = StudentTaskSubmitStatus.idle,
    this.failure,
    this.pickedFilePath,
    this.pickedFileName,
  });

  final StudentTaskSubmitStatus status;
  final GlobalFailure? failure;
  final String? pickedFilePath;
  final String? pickedFileName;

  bool get isSubmitting => status == StudentTaskSubmitStatus.submitting;

  StudentTaskSubmitState copyWith({
    StudentTaskSubmitStatus? status,
    GlobalFailure? failure,
    bool clearFailure = false,
    String? pickedFilePath,
    String? pickedFileName,
    bool clearPickedFile = false,
  }) {
    return StudentTaskSubmitState(
      status: status ?? this.status,
      failure: clearFailure ? null : (failure ?? this.failure),
      pickedFilePath: clearPickedFile ? null : (pickedFilePath ?? this.pickedFilePath),
      pickedFileName: clearPickedFile ? null : (pickedFileName ?? this.pickedFileName),
    );
  }

  @override
  List<Object?> get props => [status, failure, pickedFilePath, pickedFileName];
}
