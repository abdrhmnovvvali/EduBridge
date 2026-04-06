import 'package:eduroom/core/constants/app_colors.dart';
import 'package:eduroom/data/models/remote/response/student/invoice_summary_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// API-dən gələn `summary` üçün üst xətt.
class InvoiceSummaryStrip extends StatelessWidget {
  const InvoiceSummaryStrip({super.key, required this.summary});

  final InvoiceSummaryResponse summary;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        color: AppColors.graySoft50,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.graySoft100),
      ),
      child: Wrap(
        spacing: 16.w,
        runSpacing: 8.h,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          _chip('Total', '${summary.totalCount}', AppColors.black500),
          _chip('Paid', '₼${summary.paidAmount.toStringAsFixed(0)} (${summary.paidCount})', AppColors.secondary700),
          _chip('Unpaid', '₼${summary.unpaidAmount.toStringAsFixed(0)} (${summary.unpaidCount})', AppColors.red500),
          if (summary.waivedCount > 0)
            _chip('Waived', '${summary.waivedCount}', AppColors.black300),
        ],
      ),
    );
  }

  Widget _chip(String label, String value, Color valueColor) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$label: ',
          style: TextStyle(fontSize: 12.sp, color: AppColors.black300),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600, color: valueColor),
        ),
      ],
    );
  }
}
