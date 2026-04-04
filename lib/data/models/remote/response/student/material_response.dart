import '../../../../../core/base/model/base_model.dart';

class MaterialResponse extends BaseModel {
  final int id;
  final int classId;
  final String type;
  final String title;
  final String? linkUrl;
  final String? filePath;
  final DateTime createdAt;
  final String? className;

  MaterialResponse({
    required this.id,
    required this.classId,
    required this.type,
    required this.title,
    this.linkUrl,
    this.filePath,
    required this.createdAt,
    this.className,
  });

  factory MaterialResponse.fromJson(Map<String, dynamic> json) => MaterialResponse(
        id: json["id"],
        classId: json["class_id"] ?? json["classId"] ?? 0,
        type: json["type"] ?? "LINK",
        title: json["title"] ?? "",
        linkUrl: json["link_url"] ?? json["linkUrl"],
        filePath: json["file_path"] ?? json["filePath"],
        createdAt: DateTime.parse(json["created_at"] ?? json["createdAt"] ?? DateTime.now().toIso8601String()),
        className: json["className"] ?? json["class_name"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "classId": classId,
        "type": type,
        "title": title,
        "linkUrl": linkUrl,
        "filePath": filePath,
        "createdAt": createdAt.toIso8601String(),
        "className": className,
      };

  @override
  List<Object?> get props => [id, title];
}
