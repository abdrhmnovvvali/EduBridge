import 'package:eduroom/data/models/remote/response/student/invoice_response.dart';
import 'package:eduroom/data/models/remote/response/student/invoice_summary_response.dart';

/// GET /student/me/invoices — `{ invoices: [], summary: {} }` və ya köhnə birbaşa massiv.
class InvoicesListResponse {
  const InvoicesListResponse({
    required this.invoices,
    this.summary,
  });

  final List<InvoiceResponse> invoices;
  final InvoiceSummaryResponse? summary;

  factory InvoicesListResponse.fromResponseBody(dynamic data) {
    if (data is Map<String, dynamic>) {
      final raw = data['invoices'];
      final list = raw is List ? raw : <dynamic>[];
      final invoices = list
          .map((e) => InvoiceResponse.fromJson(e as Map<String, dynamic>))
          .toList();
      final summaryRaw = data['summary'];
      final summary = summaryRaw is Map<String, dynamic>
          ? InvoiceSummaryResponse.fromJson(summaryRaw)
          : null;
      return InvoicesListResponse(invoices: invoices, summary: summary);
    }
    if (data is List) {
      return InvoicesListResponse(
        invoices: data
            .map((e) => InvoiceResponse.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
    }
    return const InvoicesListResponse(invoices: []);
  }
}
