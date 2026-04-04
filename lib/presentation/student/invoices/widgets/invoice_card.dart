import 'package:eduroom/core/constants/app_colors.dart';
import 'package:eduroom/data/models/remote/response/student/invoice_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InvoiceCard extends StatelessWidget {
  const InvoiceCard({super.key, required this.invoice});

  final InvoiceResponse invoice;

  Color get _statusColor => invoice.status == 'PAID' ? AppColors.secondary700 : AppColors.red500;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.graySoft50,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.graySoft100),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(invoice.monthKey, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
              if (invoice.className != null)
                Text(invoice.className!, style: TextStyle(fontSize: 12.sp, color: AppColors.black300)),
              Text(invoice.status, style: TextStyle(fontSize: 12.sp, color: _statusColor, fontWeight: FontWeight.w500)),
            ],
          ),
          Text('₹${invoice.amount.toStringAsFixed(0)}', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: AppColors.bgColor)),
        ],
      ),
    );
  }
}
