/// Matches edutrack `GET /student/me/attendance` → `summary`.
class AttendanceSummaryResponse {
  AttendanceSummaryResponse({
    required this.totalSessions,
    required this.attendedCount,
    required this.absentCount,
    this.attendancePercentage,
  });

  final int totalSessions;
  final int attendedCount;
  final int absentCount;
  final int? attendancePercentage;

  factory AttendanceSummaryResponse.fromJson(Map<String, dynamic> json) {
    return AttendanceSummaryResponse(
      totalSessions: _parseInt(json['totalSessions'] ?? json['total_sessions']) ?? 0,
      attendedCount: _parseInt(json['attendedCount'] ?? json['attended_count']) ?? 0,
      absentCount: _parseInt(json['absentCount'] ?? json['absent_count']) ?? 0,
      attendancePercentage: _parseInt(json['attendancePercentage'] ?? json['attendance_percentage']),
    );
  }

  static int? _parseInt(dynamic v) {
    if (v == null) return null;
    if (v is int) return v;
    return int.tryParse(v.toString());
  }
}
