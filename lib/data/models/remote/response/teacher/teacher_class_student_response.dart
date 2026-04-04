import '../../../../../core/base/model/base_model.dart';

class TeacherClassStudentResponse extends BaseModel {
  final int id;
  final int? userId;
  final String name;

  TeacherClassStudentResponse({required this.id, this.userId, required this.name});

  int get effectiveUserId => userId ?? id;

  static int? _parseInt(dynamic v) {
    if (v == null) return null;
    if (v is int) return v;
    return int.tryParse(v.toString());
  }

  factory TeacherClassStudentResponse.fromJson(Map<String, dynamic> json) =>
      TeacherClassStudentResponse(
        id: json["id"],
        userId: _parseInt(json["userId"] ?? json["user_id"]),
        name: json["name"] ?? json["fullName"] ?? "",
      );

  @override
  Map<String, dynamic> toJson() => {"id": id, "userId": userId, "name": name};

  @override
  List<Object?> get props => [id];
}
