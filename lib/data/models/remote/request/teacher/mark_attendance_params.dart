class MarkAttendanceParams {
  final int sessionId;
  final List<AttendanceEntry> attendance;

  MarkAttendanceParams({required this.sessionId, required this.attendance});

  Map<String, dynamic> toJson() => {
        "sessionId": sessionId,
        "attendance": attendance.map((e) => e.toJson()).toList(),
      };
}

class AttendanceEntry {
  final int studentUserId;
  final String status; // "present" | "absent"
  final String note;

  AttendanceEntry({required this.studentUserId, required this.status, this.note = ''});

  Map<String, dynamic> toJson() => {
        "studentUserId": studentUserId,
        "status": status,
        "note": note,
      };
}
