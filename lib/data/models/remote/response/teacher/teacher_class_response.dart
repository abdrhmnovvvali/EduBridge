import '../../../../../core/base/model/base_model.dart';

class TeacherClassResponse extends BaseModel {
  final int id;
  final String name;
  final String? number;
  final String? specialization;
  final String? courseName;
  final int? courseId;

  TeacherClassResponse({
    required this.id,
    required this.name,
    this.number,
    this.specialization,
    this.courseName,
    this.courseId,
  });

  factory TeacherClassResponse.fromJson(Map<String, dynamic> json) {
    final course = json["course"];
    String? courseName = json["courseName"] ?? json["course_name"];
    if (courseName == null && course is Map) {
      courseName = course["name"];
    }
    return TeacherClassResponse(
      id: json["id"],
      name: json["name"] ?? "",
      number: json["number"],
      specialization: json["specialization"],
      courseName: courseName,
      courseId: json["courseId"] ?? json["course_id"] ?? (course is Map ? course["id"] : null),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "number": number,
        "specialization": specialization,
        "courseName": courseName,
        "courseId": courseId,
      };

  @override
  List<Object?> get props => [id, name];
}
