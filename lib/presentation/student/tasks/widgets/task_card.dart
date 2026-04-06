import 'package:eduroom/core/constants/app_colors.dart';
import 'package:eduroom/data/models/remote/response/student/task_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.task, this.onTap});

  final TaskResponse task;
  final VoidCallback? onTap;

  static String _taskContextLine(TaskResponse task) {
    final parts = <String>[];
    if (task.className != null && task.className!.trim().isNotEmpty) {
      parts.add(task.className!.trim());
    }
    if (task.courseName != null && task.courseName!.trim().isNotEmpty) {
      parts.add(task.courseName!.trim());
    }
    return parts.join(' · ');
  }

  @override
  Widget build(BuildContext context) {
    final contextLine = _taskContextLine(task);
    final card = Container(
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
          Row(
            children: [
              Expanded(
                child: Text(
                  task.title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (onTap != null)
                Icon(
                  Icons.chevron_right,
                  color: AppColors.graySoft25,
                  size: 22.r,
                ),
            ],
          ),
          if (contextLine.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(top: 6.h),
              child: Text(
                contextLine,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.black300,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          if (task.description != null && task.description!.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Text(
                task.description!,
                style: TextStyle(fontSize: 14.sp, color: AppColors.black500),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          if (task.dueAt != null)
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Text(
                'Due: ${DateFormat('MMM d, y').format(task.dueAt!)}',
                style: TextStyle(fontSize: 12.sp, color: AppColors.black300),
              ),
            ),
        ],
      ),
    );

    if (onTap == null) return card;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: card,
      ),
    );
  }
}
