import 'package:eduroom/core/constants/app_colors.dart';
import 'package:eduroom/data/models/remote/response/student/grade_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GradeCard extends StatelessWidget {
  const GradeCard({super.key, required this.grade});

  final GradeResponse grade;

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
              Text(
                grade.dateKey,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
              if (grade.className != null)
                Text(
                  grade.className!,
                  style: TextStyle(fontSize: 12.sp, color: AppColors.black300),
                ),
              if (grade.note != null && grade.note!.isNotEmpty)
                Text(
                  grade.note!,
                  style: TextStyle(fontSize: 12.sp, color: AppColors.black500),
                ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: AppColors.bgColor,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              '${grade.value}',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
