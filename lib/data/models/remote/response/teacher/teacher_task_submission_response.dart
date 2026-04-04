import '../../../../../core/base/model/base_model.dart';

class TeacherTaskSubmissionResponse extends BaseModel {
  final int id;
  final int taskId;
  final int studentId;
  final String? studentName;
  final String? content;
  final String? attachmentUrl;
  final String status;
  final DateTime? submittedAt;
  final String? feedback;

  TeacherTaskSubmissionResponse({
    required this.id,
    required this.taskId,
    required this.studentId,
    this.studentName,
    this.content,
    this.attachmentUrl,
    required this.status,
    this.submittedAt,
    this.feedback,
  });

  factory TeacherTaskSubmissionResponse.fromJson(Map<String, dynamic> json) =>
      TeacherTaskSubmissionResponse(
        id: json["id"],
        taskId: json["task_id"] ?? json["taskId"] ?? 0,
        studentId: json["student_id"] ?? json["studentId"] ?? 0,
        studentName: json["student_name"] ?? json["studentName"],
        content: json["content"],
        attachmentUrl: json["attachment_url"] ?? json["attachmentUrl"],
        status: json["status"] ?? "pending",
        submittedAt: json["submitted_at"] != null || json["submittedAt"] != null
            ? DateTime.tryParse((json["submitted_at"] ?? json["submittedAt"]).toString())
            : null,
        feedback: json["feedback"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "taskId": taskId,
        "studentId": studentId,
        "studentName": studentName,
        "content": content,
        "attachmentUrl": attachmentUrl,
        "status": status,
        "submittedAt": submittedAt?.toIso8601String(),
        "feedback": feedback,
      };

  @override
  List<Object?> get props => [id];
}
