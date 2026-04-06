/// GET /student/me/invoices → `summary` obyekti.
class InvoiceSummaryResponse {
  const InvoiceSummaryResponse({
    required this.totalCount,
    required this.unpaidCount,
    required this.unpaidAmount,
    required this.paidCount,
    required this.paidAmount,
    required this.waivedCount,
  });

  final int totalCount;
  final int unpaidCount;
  final double unpaidAmount;
  final int paidCount;
  final double paidAmount;
  final int waivedCount;

  factory InvoiceSummaryResponse.fromJson(Map<String, dynamic> json) {
    double toD(dynamic v) {
      if (v == null) return 0;
      if (v is num) return v.toDouble();
      return double.tryParse('$v') ?? 0;
    }

    int toI(dynamic v) {
      if (v is int) return v;
      if (v is num) return v.toInt();
      return int.tryParse('$v') ?? 0;
    }

    return InvoiceSummaryResponse(
      totalCount: toI(json['totalCount'] ?? json['total_count']),
      unpaidCount: toI(json['unpaidCount'] ?? json['unpaid_count']),
      unpaidAmount: toD(json['unpaidAmount'] ?? json['unpaid_amount']),
      paidCount: toI(json['paidCount'] ?? json['paid_count']),
      paidAmount: toD(json['paidAmount'] ?? json['paid_amount']),
      waivedCount: toI(json['waivedCount'] ?? json['waived_count']),
    );
  }
}
