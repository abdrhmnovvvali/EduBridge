import '../../../../../core/base/model/base_model.dart';

class MaterialResponse extends BaseModel {
  final int id;
  final int classId;
  final int? courseId;
  final String type;
  final String title;
  final String? linkUrl;
  final String? filePath;
  final String? fileUrl;
  final String? mimeType;
  final int? size;
  final DateTime createdAt;
  final String? className;
  final String? courseName;

  MaterialResponse({
    required this.id,
    required this.classId,
    this.courseId,
    required this.type,
    required this.title,
    this.linkUrl,
    this.filePath,
    this.fileUrl,
    this.mimeType,
    this.size,
    required this.createdAt,
    this.className,
    this.courseName,
  });

  bool get isFileType => type.toUpperCase() == 'FILE';

  /// Prefer public URL from API; fallback to absolute path strings.
  String? get openableUri {
    final u = fileUrl ?? linkUrl;
    if (u != null && u.isNotEmpty) return u;
    final p = filePath;
    if (p != null && p.isNotEmpty && (p.startsWith('http://') || p.startsWith('https://'))) return p;
    return null;
  }

  factory MaterialResponse.fromJson(Map<String, dynamic> json) => MaterialResponse(
        id: json["id"],
        classId: json["class_id"] ?? json["classId"] ?? 0,
        courseId: json["course_id"] ?? json["courseId"],
        type: json["type"] ?? "LINK",
        title: json["title"] ?? "",
        linkUrl: json["link_url"] ?? json["linkUrl"],
        filePath: json["file_path"] ?? json["filePath"],
        fileUrl: json["file_url"] ?? json["fileUrl"],
        mimeType: json["mime_type"] ?? json["mimeType"],
        size: json["size"] is int ? json["size"] as int : int.tryParse('${json["size"]}'),
        createdAt: DateTime.parse(json["created_at"] ?? json["createdAt"] ?? DateTime.now().toIso8601String()),
        className: json["className"] ?? json["class_name"],
        courseName: json["courseName"] ?? json["course_name"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "classId": classId,
        "courseId": courseId,
        "type": type,
        "title": title,
        "linkUrl": linkUrl,
        "filePath": filePath,
        "fileUrl": fileUrl,
        "mimeType": mimeType,
        "size": size,
        "createdAt": createdAt.toIso8601String(),
        "className": className,
        "courseName": courseName,
      };

  @override
  List<Object?> get props => [id, title];
}
