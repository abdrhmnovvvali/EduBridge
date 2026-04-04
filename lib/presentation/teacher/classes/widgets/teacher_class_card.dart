import 'package:eduroom/core/constants/app_colors.dart';
import 'package:eduroom/data/models/remote/response/teacher/teacher_class_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TeacherClassCard extends StatelessWidget {
  const TeacherClassCard({super.key, required this.clazz});

  final TeacherClassResponse clazz;

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(clazz.name, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
          if (clazz.courseName != null && clazz.courseName!.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Text(clazz.courseName!, style: TextStyle(fontSize: 14.sp, color: AppColors.black500)),
            ),
          if (clazz.number != null && clazz.number!.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(top: 4.h),
              child: Text(clazz.number!, style: TextStyle(fontSize: 12.sp, color: AppColors.black300)),
            ),
          if (clazz.specialization != null && clazz.specialization!.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(top: 4.h),
              child: Text(clazz.specialization!, style: TextStyle(fontSize: 12.sp, color: AppColors.graySoft25)),
            ),
        ],
      ),
    );
  }
}
