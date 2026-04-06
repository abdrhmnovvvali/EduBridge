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

  factory NotificationResponse.fromJson(Map<String, dynamic> json) {
    final readRaw = json['isRead'] ?? json['is_read'];
    final isRead = readRaw == true ||
        json["status"] == "READ" ||
        json["read_at"] != null ||
        json["readAt"] != null;

    final created = json["created_at"] ?? json["createdAt"] ?? json["created"];
    return NotificationResponse(
      id: json["id"] is int ? json["id"] as int : int.tryParse('${json["id"]}') ?? 0,
      type: '${json["type"] ?? "info"}',
      title: '${json["title"] ?? ""}',
      body: json["body"]?.toString(),
      isRead: isRead,
      createdAt: created != null
          ? DateTime.tryParse(created.toString()) ?? DateTime.now()
          : DateTime.now(),
    );
  }

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
