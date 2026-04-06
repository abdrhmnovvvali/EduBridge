import 'package:eduroom/core/constants/app_colors.dart';
import 'package:eduroom/data/models/remote/response/student/attendance_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class AttendanceCard extends StatelessWidget {
  const AttendanceCard({super.key, required this.item});

  final AttendanceResponse item;

  Color get _statusColor {
    switch (item.status.toUpperCase()) {
      case 'PRESENT':
        return AppColors.secondary700;
      case 'LATE':
        return AppColors.yellow;
      case 'ABSENT':
        return AppColors.red500;
      default:
        return AppColors.black500;
    }
  }

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
        children: [
          Container(
            width: 8.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: _statusColor,
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.status.toUpperCase(),
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: _statusColor,
                  ),
                ),
                if (item.sessionDate != null)
                  Text(
                    DateFormat('MMM d, y').format(item.sessionDate!),
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.black500,
                    ),
                  ),
                if (item.className != null)
                  Text(
                    item.className!,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.black300,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
