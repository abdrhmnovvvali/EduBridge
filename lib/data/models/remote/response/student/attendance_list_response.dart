import 'attendance_response.dart';
import 'attendance_summary_response.dart';

/// Parses edutrack `GET /student/me/attendance`:
/// `{ summary: {...}, records: [...] }`
/// Plus legacy shapes: `{ items, absentCount }`, plain list.
class AttendanceListResponse {
  AttendanceListResponse({
    required this.items,
    required this.absentCount,
    this.summary,
  });

  final List<AttendanceResponse> items;
  /// Prefer [summary.absentCount] when API sends `summary` (edutrack).
  final int absentCount;
  final AttendanceSummaryResponse? summary;

  factory AttendanceListResponse.fromJson(Map<String, dynamic> json) {
    final list = json['records'] ??
        json['items'] ??
        json['attendance'] ??
        json['data'] ??
        [];
    final items = list is List
        ? list.map((e) => AttendanceResponse.fromJson(e as Map<String, dynamic>)).toList()
        : <AttendanceResponse>[];

    AttendanceSummaryResponse? summary;
    int absentCount;

    final summaryRaw = json['summary'];
    if (summaryRaw is Map<String, dynamic>) {
      summary = AttendanceSummaryResponse.fromJson(summaryRaw);
      absentCount = summary!.absentCount;
    } else {
      absentCount = _parseInt(json['absentCount'] ?? json['absent_count']) ??
          items.where((e) => e.status.toUpperCase() == 'ABSENT').length;
    }

    return AttendanceListResponse(
      items: items,
      absentCount: absentCount,
      summary: summary,
    );
  }

  static int? _parseInt(dynamic v) {
    if (v == null) return null;
    if (v is int) return v;
    return int.tryParse(v.toString());
  }
}
