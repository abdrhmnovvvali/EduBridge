import 'package:eduroom/core/constants/app_colors.dart';
import 'package:eduroom/data/models/remote/response/student/student_teacher_feedback_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TeacherFeedbackCard extends StatelessWidget {
  const TeacherFeedbackCard({super.key, required this.item});

  final StudentTeacherFeedbackItem item;

  String _fmt(DateTime? d) {
    if (d == null) return '—';
    return '${d.day.toString().padLeft(2, '0')}.${d.month.toString().padLeft(2, '0')}.${d.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.taskTitle,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.black500,
            ),
          ),
          if (item.taskDescription != null &&
              item.taskDescription!.isNotEmpty) ...[
            SizedBox(height: 6.h),
            Text(
              item.taskDescription!,
              style: TextStyle(fontSize: 13.sp, color: Colors.black54),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          SizedBox(height: 8.h),
          Text(
            item.className,
            style: TextStyle(fontSize: 12.sp, color: AppColors.bgColor),
          ),
          if (item.answer != null && item.answer!.isNotEmpty) ...[
            SizedBox(height: 10.h),
            Text(
              'Your answer',
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 4.h),
            Text(item.answer!, style: TextStyle(fontSize: 13.sp)),
          ],
          SizedBox(height: 10.h),
          Row(
            children: [
              Text(
                item.status,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.blueGrey,
                ),
              ),
              if (item.teacher?.fullName != null) ...[
                Text(
                  ' · ',
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                ),
                Expanded(
                  child: Text(
                    item.teacher!.fullName,
                    style: TextStyle(fontSize: 12.sp, color: Colors.black87),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ],
          ),
          if (item.teacherFeedback != null &&
              item.teacherFeedback!.isNotEmpty) ...[
            SizedBox(height: 10.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: AppColors.bgColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Teacher feedback',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    item.teacherFeedback!,
                    style: TextStyle(fontSize: 13.sp),
                  ),
                ],
              ),
            ),
          ],
          SizedBox(height: 8.h),
          Text(
            'Submitted: ${_fmt(item.submittedAt)} · Reviewed: ${_fmt(item.reviewedAt)}',
            style: TextStyle(fontSize: 11.sp, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
