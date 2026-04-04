import '../../../../../core/base/model/base_model.dart';

class LeaderboardResponse extends BaseModel {
  final List<LeaderboardItem> items;

  LeaderboardResponse({required this.items});

  factory LeaderboardResponse.fromJson(dynamic json) {
    List<dynamic> list;
    if (json is List) {
      list = json;
    } else if (json is Map<String, dynamic>) {
      list = json["items"] ?? json["leaderboard"] ?? [];
    } else {
      list = [];
    }
    return LeaderboardResponse(
      items: list.asMap().entries.map((e) {
        final item = e.value as Map<String, dynamic>;
        item["rank"] = e.key + 1;
        return LeaderboardItem.fromJson(item);
      }).toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() => {"items": items.map((e) => e.toJson()).toList()};

  @override
  List<Object?> get props => [items];
}

class LeaderboardItem extends BaseModel {
  final int rank;
  final int studentId;
  final String studentName;
  final double value;

  LeaderboardItem({
    required this.rank,
    required this.studentId,
    required this.studentName,
    required this.value,
  });

  factory LeaderboardItem.fromJson(Map<String, dynamic> json) => LeaderboardItem(
        rank: json["rank"] ?? 0,
        studentId: json["student_user_id"] ?? json["studentUserId"] ?? json["studentId"] ?? 0,
        studentName: json["full_name"] ?? json["fullName"] ?? json["studentName"] ?? "",
        value: ((json["average_grade"] ?? json["averageGrade"] ?? json["value"]) as num?)?.toDouble() ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "rank": rank,
        "studentId": studentId,
        "studentName": studentName,
        "value": value,
      };

  @override
  List<Object?> get props => [rank, studentId];
}
