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

  factory AttendanceResponse.fromJson(Map<String, dynamic> json) => AttendanceResponse(
        id: json["id"],
        status: json["status"] ?? "present",
        sessionDate: json["session_date"] != null
            ? DateTime.tryParse(json["session_date"].toString())
            : (json["sessionDate"] != null ? DateTime.tryParse(json["sessionDate"].toString()) : null),
        className: json["className"] ?? json["class_name"],
        note: json["note"],
      );

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
