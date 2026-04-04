import '../../../../../core/base/model/base_model.dart';

class InvoiceResponse extends BaseModel {
  final int id;
  final String monthKey;
  final double amount;
  final String status;
  final String? className;

  InvoiceResponse({
    required this.id,
    required this.monthKey,
    required this.amount,
    required this.status,
    this.className,
  });

  factory InvoiceResponse.fromJson(Map<String, dynamic> json) => InvoiceResponse(
        id: json["id"],
        monthKey: json["month_key"] ?? json["monthKey"] ?? "",
        amount: (json["amount"] ?? 0).toDouble(),
        status: json["status"] ?? "UNPAID",
        className: json["className"] ?? json["class_name"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "monthKey": monthKey,
        "amount": amount,
        "status": status,
        "className": className,
      };

  @override
  List<Object?> get props => [id, monthKey];
}
