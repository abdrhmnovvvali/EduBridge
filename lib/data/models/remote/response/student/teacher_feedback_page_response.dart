import 'package:eduroom/data/models/remote/response/student/student_teacher_feedback_item.dart';

class TeacherFeedbackPageResponse {
  TeacherFeedbackPageResponse({
    required this.data,
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
  });

  final List<StudentTeacherFeedbackItem> data;
  final int total;
  final int page;
  final int limit;
  final int totalPages;

  factory TeacherFeedbackPageResponse.fromJson(Map<String, dynamic> json) {
    final raw = json['data'];
    final list = raw is List ? raw : <dynamic>[];
    return TeacherFeedbackPageResponse(
      data: list
          .map((e) => StudentTeacherFeedbackItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: _toInt(json['total']),
      page: _toInt(json['page'], fallback: 1),
      limit: _toInt(json['limit'], fallback: 20),
      totalPages: _toInt(json['totalPages'] ?? json['total_pages']),
    );
  }

  static int _toInt(dynamic v, {int fallback = 0}) {
    if (v is int) return v;
    if (v is num) return v.toInt();
    return int.tryParse('$v') ?? fallback;
  }
}
