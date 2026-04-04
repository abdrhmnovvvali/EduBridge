import 'package:eduroom/core/constants/app_colors.dart';
import 'package:eduroom/data/models/remote/response/student/task_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.task});

  final TaskResponse task;

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
          Text(task.title, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
          if (task.description != null && task.description!.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Text(task.description!, style: TextStyle(fontSize: 14.sp, color: AppColors.black500), maxLines: 2, overflow: TextOverflow.ellipsis),
            ),
          if (task.dueAt != null)
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Text('Due: ${DateFormat('MMM d, y').format(task.dueAt!)}', style: TextStyle(fontSize: 12.sp, color: AppColors.black300)),
            ),
          if (task.className != null)
            Padding(
              padding: EdgeInsets.only(top: 4.h),
              child: Text(task.className!, style: TextStyle(fontSize: 12.sp, color: AppColors.graySoft25)),
            ),
        ],
      ),
    );
  }
}
