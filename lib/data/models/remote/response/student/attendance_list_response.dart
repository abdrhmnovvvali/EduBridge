import 'attendance_response.dart';

class AttendanceListResponse {
  final List<AttendanceResponse> items;
  final int absentCount;

  AttendanceListResponse({required this.items, required this.absentCount});

  factory AttendanceListResponse.fromJson(Map<String, dynamic> json) {
    final list = json["items"] ?? json["attendance"] ?? json["data"] ?? [];
    final items = list is List
        ? list.map((e) => AttendanceResponse.fromJson(e as Map<String, dynamic>)).toList()
        : <AttendanceResponse>[];
    final absentCount = _parseInt(json["absentCount"] ?? json["absent_count"]) ?? 0;
    return AttendanceListResponse(items: items, absentCount: absentCount);
  }

  static int? _parseInt(dynamic v) {
    if (v == null) return null;
    if (v is int) return v;
    return int.tryParse(v.toString());
  }
}
