import '../../../../../core/base/model/base_model.dart';

class InvoiceResponse extends BaseModel {
  final int id;
  final String monthKey;
  final double amount;
  final String status;
  final String? className;
  final int? courseId;
  final String? courseName;
  final int? classId;
  final String? classNumber;
  final String? paymentMode;
  final DateTime? paidAt;
  final DateTime? updatedAt;

  InvoiceResponse({
    required this.id,
    required this.monthKey,
    required this.amount,
    required this.status,
    this.className,
    this.courseId,
    this.courseName,
    this.classId,
    this.classNumber,
    this.paymentMode,
    this.paidAt,
    this.updatedAt,
  });

  factory InvoiceResponse.fromJson(Map<String, dynamic> json) {
    DateTime? parseDt(dynamic v) {
      if (v == null) return null;
      return DateTime.tryParse(v.toString());
    }

    return InvoiceResponse(
      id: json['id'] is int ? json['id'] as int : int.tryParse('${json['id']}') ?? 0,
      monthKey: '${json['month_key'] ?? json['monthKey'] ?? ''}',
      amount: (json['amount'] is num) ? (json['amount'] as num).toDouble() : double.tryParse('${json['amount'] ?? 0}') ?? 0,
      status: '${json['status'] ?? 'UNPAID'}',
      className: json['className']?.toString() ?? json['class_name']?.toString(),
      courseId: _optInt(json['courseId'] ?? json['course_id']),
      courseName: json['courseName']?.toString() ?? json['course_name']?.toString(),
      classId: _optInt(json['classId'] ?? json['class_id']),
      classNumber: json['classNumber']?.toString() ?? json['class_number']?.toString(),
      paymentMode: json['paymentMode']?.toString() ?? json['payment_mode']?.toString(),
      paidAt: parseDt(json['paidAt'] ?? json['paid_at']),
      updatedAt: parseDt(json['updatedAt'] ?? json['updated_at']),
    );
  }

  static int? _optInt(dynamic v) {
    if (v == null) return null;
    if (v is int) return v;
    if (v is num) return v.toInt();
    return int.tryParse('$v');
  }

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'monthKey': monthKey,
        'amount': amount,
        'status': status,
        'className': className,
        'courseId': courseId,
        'courseName': courseName,
        'classId': classId,
        'classNumber': classNumber,
        'paymentMode': paymentMode,
        'paidAt': paidAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };

  @override
  List<Object?> get props => [
        id,
        monthKey,
        amount,
        status,
        className,
        courseId,
        courseName,
        classId,
        classNumber,
        paymentMode,
        paidAt,
        updatedAt,
      ];
}
