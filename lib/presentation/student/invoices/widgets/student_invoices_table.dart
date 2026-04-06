import 'package:eduroom/core/constants/app_colors.dart';
import 'package:eduroom/data/models/remote/response/student/invoice_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

/// Ödənişlərin izlənməsi üçün cədvəl (GET /student/me/invoices).
class StudentInvoicesTable extends StatelessWidget {
  const StudentInvoicesTable({super.key, required this.invoices});

  final List<InvoiceResponse> invoices;

  static final _periodFmt = DateFormat.yMMM();
  static final _paidFmt = DateFormat('dd.MM.yyyy');

  Color _statusColor(String status) {
    final s = status.toUpperCase();
    if (s == 'PAID') return AppColors.secondary700;
    if (s == 'PARTIAL' || s == 'PENDING') return AppColors.yellow;
    if (s == 'WAIVED') return AppColors.black300;
    return AppColors.red500;
  }

  String _formatPeriod(String monthKey) {
    final d = DateTime.tryParse(monthKey.length >= 10 ? monthKey.substring(0, 10) : monthKey);
    if (d == null) return monthKey;
    return _periodFmt.format(d);
  }

  String _classLabel(InvoiceResponse inv) {
    final name = inv.className?.trim();
    final num = inv.classNumber?.trim();
    if (name != null && name.isNotEmpty) {
      if (num != null && num.isNotEmpty) return '$name · $num';
      return name;
    }
    return '—';
  }

  String _paidLabel(InvoiceResponse inv) {
    if (inv.paidAt != null) return _paidFmt.format(inv.paidAt!.toLocal());
    return '—';
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final minTableWidth = constraints.maxWidth < 640 ? 640.0 : constraints.maxWidth;
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: minTableWidth),
            child: DataTable(
              headingRowHeight: 44.h,
              dataRowMinHeight: 48.h,
              dataRowMaxHeight: 64.h,
              headingRowColor: WidgetStateProperty.all(
                AppColors.bgColor.withValues(alpha: 0.12),
              ),
              border: TableBorder(
                horizontalInside: BorderSide(color: AppColors.graySoft100),
                bottom: BorderSide(color: AppColors.graySoft100),
                top: BorderSide(color: AppColors.graySoft100),
              ),
              columnSpacing: 16.w,
              horizontalMargin: 12.w,
              columns: [
                DataColumn(
                  label: Text(
                    'Period',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13.sp,
                      color: AppColors.black500,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Class',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13.sp,
                      color: AppColors.black500,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Status',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13.sp,
                      color: AppColors.black500,
                    ),
                  ),
                ),
                DataColumn(
                  numeric: true,
                  label: Text(
                    'Amount',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13.sp,
                      color: AppColors.black500,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Paid',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13.sp,
                      color: AppColors.black500,
                    ),
                  ),
                ),
              ],
              rows: invoices.map((inv) {
                return DataRow(
                  cells: [
                    DataCell(
                      Text(
                        _formatPeriod(inv.monthKey),
                        style: TextStyle(fontSize: 13.sp, color: AppColors.black900),
                      ),
                    ),
                    DataCell(
                      Text(
                        _classLabel(inv),
                        style: TextStyle(fontSize: 13.sp, color: AppColors.black500),
                      ),
                    ),
                    DataCell(
                      Text(
                        inv.status,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: _statusColor(inv.status),
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        '₼${inv.amount.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.bgColor,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        _paidLabel(inv),
                        style: TextStyle(fontSize: 12.sp, color: AppColors.black500),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
