import '../../../../../core/base/model/base_model.dart';

class TaskResponse extends BaseModel {
  final int id;
  final int courseId;
  final int classId;
  final String title;
  final String? description;
  final DateTime? dueAt;
  final DateTime createdAt;
  final String? className;
  final String? courseName;

  TaskResponse({
    required this.id,
    required this.courseId,
    required this.classId,
    required this.title,
    this.description,
    this.dueAt,
    required this.createdAt,
    this.className,
    this.courseName,
  });

  factory TaskResponse.fromJson(Map<String, dynamic> json) => TaskResponse(
        id: json["id"],
        courseId: json["course_id"] ?? json["courseId"] ?? 0,
        classId: json["class_id"] ?? json["classId"] ?? 0,
        title: json["title"] ?? "",
        description: json["description"],
        dueAt: json["due_at"] != null
            ? DateTime.tryParse(json["due_at"].toString())
            : (json["dueAt"] != null ? DateTime.tryParse(json["dueAt"].toString()) : null),
        createdAt: DateTime.parse(json["created_at"] ?? json["createdAt"] ?? DateTime.now().toIso8601String()),
        className: json["className"] ?? json["class_name"],
        courseName: json["courseName"] ?? json["course_name"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "courseId": courseId,
        "classId": classId,
        "title": title,
        "description": description,
        "dueAt": dueAt?.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "className": className,
        "courseName": courseName,
      };

  @override
  List<Object?> get props => [id, title, dueAt];
}
