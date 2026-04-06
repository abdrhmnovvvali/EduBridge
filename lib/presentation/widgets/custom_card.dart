import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.asset,
    this.value,
    this.label,
    this.top,
    required this.color,
  });
  final String asset;
  final String? value;
  final String? label;
  final double? top;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 163.w,
      height: 202.h,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 2.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(top: top ?? 0, left: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(asset),
            SizedBox(height: 14.h),
            Text(
              value ?? "",
              style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),
            ),
            Text(
              label ?? "",
              style: TextStyle(fontSize: 16.sp, color: AppColors.black500),
            ),
          ],
        ),
      ),
    );
  }
}
