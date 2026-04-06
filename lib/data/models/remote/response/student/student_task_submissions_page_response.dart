import 'package:eduroom/data/models/remote/response/student/student_task_submission_response.dart';

/// GET /student/me/tasks/submissions — səhifələnmiş cavab (API ilə uyğun forma).
class StudentTaskSubmissionsPageResponse {
  StudentTaskSubmissionsPageResponse({
    required this.data,
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
  });

  final List<StudentTaskSubmissionResponse> data;
  final int total;
  final int page;
  final int limit;
  final int totalPages;

  factory StudentTaskSubmissionsPageResponse.fromJson(Map<String, dynamic> json) {
    final raw = json['data'];
    final list = raw is List ? raw : <dynamic>[];
    return StudentTaskSubmissionsPageResponse(
      data: list
          .map((e) => StudentTaskSubmissionResponse.fromJson(e as Map<String, dynamic>))
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
