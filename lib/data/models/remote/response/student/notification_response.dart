import '../../../../../core/base/model/base_model.dart';

class NotificationResponse extends BaseModel {
  final int id;
  final String type;
  final String title;
  final String? body;
  final bool isRead;
  final DateTime createdAt;

  NotificationResponse({
    required this.id,
    required this.type,
    required this.title,
    this.body,
    required this.isRead,
    required this.createdAt,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) => NotificationResponse(
        id: json["id"],
        type: json["type"] ?? "info",
        title: json["title"] ?? "",
        body: json["body"],
        isRead: json["status"] == "READ" || json["read_at"] != null || json["readAt"] != null,
        createdAt: DateTime.parse(json["created_at"] ?? json["createdAt"] ?? DateTime.now().toIso8601String()),
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "title": title,
        "body": body,
        "isRead": isRead,
        "createdAt": createdAt.toIso8601String(),
      };

  @override
  List<Object?> get props => [id, title];
}
