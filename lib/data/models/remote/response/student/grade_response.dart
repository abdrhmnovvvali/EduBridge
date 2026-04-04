import '../../../../../core/base/model/base_model.dart';

class GradeResponse extends BaseModel {
  final int id;
  final String scope;
  final String dateKey;
  final double value;
  final String? note;
  final String? className;

  GradeResponse({
    required this.id,
    required this.scope,
    required this.dateKey,
    required this.value,
    this.note,
    this.className,
  });

  static double _parseDouble(dynamic v) {
    if (v == null) return 0;
    if (v is num) return v.toDouble();
    return double.tryParse(v.toString()) ?? 0;
  }

  factory GradeResponse.fromJson(Map<String, dynamic> json) => GradeResponse(
        id: json["id"],
        scope: json["scope"] ?? "daily",
        dateKey: json["date_key"] ?? json["dateKey"] ?? "",
        value: _parseDouble(json["value"]),
        note: json["note"],
        className: json["className"] ?? json["class_name"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "scope": scope,
        "dateKey": dateKey,
        "value": value,
        "note": note,
        "className": className,
      };

  @override
  List<Object?> get props => [id, dateKey, value];
}
