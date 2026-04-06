import 'package:eduroom/data/models/remote/response/student/class_name_ref.dart';
import 'package:eduroom/data/models/remote/response/student/teacher_name_ref.dart';

/// GET /student/me/tasks/submissions — yenilənmiş cavab (teacher, class nested).
class StudentTaskSubmissionResponse {
  const StudentTaskSubmissionResponse({
    required this.id,
    required this.taskId,
    this.taskTitle,
    this.answer,
    required this.status,
    this.teacherFeedback,
    this.teacher,
    this.clazz,
    this.submittedAt,
    this.reviewedAt,
  });

  final int id;
  final int taskId;
  final String? taskTitle;
  final String? answer;
  final String status;
  final String? teacherFeedback;
  final TeacherNameRef? teacher;
  final ClassNameRef? clazz;
  final DateTime? submittedAt;
  final DateTime? reviewedAt;

  factory StudentTaskSubmissionResponse.fromJson(Map<String, dynamic> json) {
    final teacherRaw = json['teacher'] ?? json['reviewedByTeacher'];
    final classRaw = json['class'] ?? json['clazz'];

    return StudentTaskSubmissionResponse(
      id: _int(json['id'] ?? json['submissionId'] ?? json['submission_id']),
      taskId: _int(json['taskId'] ?? json['task_id']),
      taskTitle: json['taskTitle']?.toString() ?? json['task_title']?.toString(),
      answer: json['answer']?.toString() ?? json['content']?.toString(),
      status: '${json['status'] ?? ''}',
      teacherFeedback:
          json['teacherFeedback']?.toString() ?? json['teacher_feedback']?.toString(),
      teacher: teacherRaw is Map<String, dynamic> ? TeacherNameRef.fromJson(teacherRaw) : null,
      clazz: classRaw is Map<String, dynamic> ? ClassNameRef.fromJson(classRaw) : null,
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
