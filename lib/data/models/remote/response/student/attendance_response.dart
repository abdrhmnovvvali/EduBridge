import '../../../../../core/base/model/base_model.dart';

class AttendanceResponse extends BaseModel {
  final int id;
  final String status;
  final DateTime? sessionDate;
  final String? className;
  final String? note;

  AttendanceResponse({
    required this.id,
    required this.status,
    this.sessionDate,
    this.className,
    this.note,
  });

  factory AttendanceResponse.fromJson(Map<String, dynamic> json) {
    DateTime? sessionDate;
    String? className;

    if (json["session_date"] != null) {
      sessionDate = DateTime.tryParse(json["session_date"].toString());
    } else if (json["sessionDate"] != null) {
      sessionDate = DateTime.tryParse(json["sessionDate"].toString());
    } else if (json["markedAt"] != null || json["marked_at"] != null) {
      sessionDate = DateTime.tryParse((json["markedAt"] ?? json["marked_at"]).toString());
    }

    final session = json["session"];
    if (session is Map<String, dynamic>) {
      final start = session["starts_at"] ?? session["startsAt"];
      if (start != null) {
        sessionDate = DateTime.tryParse(start.toString()) ?? sessionDate;
      }
      final cls = session["class"];
      if (cls is Map<String, dynamic>) {
        className = cls["name"]?.toString();
      }
    }

    className ??= json["className"] ?? json["class_name"]?.toString();

    return AttendanceResponse(
      id: json["id"],
      status: (json["status"] ?? "present").toString(),
      sessionDate: sessionDate,
      className: className,
      note: json["note"]?.toString(),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "sessionDate": sessionDate?.toIso8601String(),
        "className": className,
        "note": note,
      };

  @override
  List<Object?> get props => [id, status];
}
