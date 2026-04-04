import '../../../../../core/base/model/base_model.dart';

class TeacherSessionResponse extends BaseModel {
  final int id;
  final int classId;
  final DateTime startsAt;
  final DateTime endsAt;
  final String status;

  TeacherSessionResponse({
    required this.id,
    required this.classId,
    required this.startsAt,
    required this.endsAt,
    required this.status,
  });

  factory TeacherSessionResponse.fromJson(Map<String, dynamic> json) =>
      TeacherSessionResponse(
        id: json["id"],
        classId: json["class_id"] ?? json["classId"] ?? 0,
        startsAt: DateTime.parse(json["starts_at"] ?? json["startsAt"] ?? DateTime.now().toIso8601String()),
        endsAt: DateTime.parse(json["ends_at"] ?? json["endsAt"] ?? DateTime.now().toIso8601String()),
        status: json["status"] ?? "scheduled",
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "classId": classId,
        "startsAt": startsAt.toIso8601String(),
        "endsAt": endsAt.toIso8601String(),
        "status": status,
      };

  @override
  List<Object?> get props => [id];
}
