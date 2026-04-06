import 'package:eduroom/data/models/remote/response/student/teacher_name_ref.dart';

/// GET /student/me/teacher-feedback elementi.
class StudentTeacherFeedbackItem {
  const StudentTeacherFeedbackItem({
    required this.submissionId,
    required this.taskId,
    required this.taskTitle,
    this.taskDescription,
    required this.classId,
    required this.className,
    this.answer,
    required this.status,
    this.teacherFeedback,
    this.teacher,
    this.submittedAt,
    this.reviewedAt,
  });

  final int submissionId;
  final int taskId;
  final String taskTitle;
  final String? taskDescription;
  final int classId;
  final String className;
  final String? answer;
  final String status;
  final String? teacherFeedback;
  final TeacherNameRef? teacher;
  final DateTime? submittedAt;
  final DateTime? reviewedAt;

  factory StudentTeacherFeedbackItem.fromJson(Map<String, dynamic> json) {
    final teacherRaw = json['teacher'];
    return StudentTeacherFeedbackItem(
      submissionId: _int(json['submissionId'] ?? json['submission_id'] ?? json['id']),
      taskId: _int(json['taskId'] ?? json['task_id']),
      taskTitle: '${json['taskTitle'] ?? json['task_title'] ?? ''}',
      taskDescription: json['taskDescription']?.toString() ?? json['task_description']?.toString(),
      classId: _int(json['classId'] ?? json['class_id']),
      className: '${json['className'] ?? json['class_name'] ?? ''}',
      answer: json['answer']?.toString(),
      status: '${json['status'] ?? ''}',
      teacherFeedback:
          json['teacherFeedback']?.toString() ?? json['teacher_feedback']?.toString(),
      teacher: teacherRaw is Map<String, dynamic> ? TeacherNameRef.fromJson(teacherRaw) : null,
      submittedAt: _dt(json['submittedAt'] ?? json['submitted_at']),
      reviewedAt: _dt(json['reviewedAt'] ?? json['reviewed_at']),
    );
  }

  static int _int(dynamic v) {
    if (v is int) return v;
    if (v is num) return v.toInt();
    return int.tryParse('$v') ?? 0;
  }

  static DateTime? _dt(dynamic v) {
    if (v == null) return null;
    return DateTime.tryParse(v.toString());
  }
}
