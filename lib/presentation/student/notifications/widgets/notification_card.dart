import 'package:eduroom/core/constants/app_colors.dart';
import 'package:eduroom/data/models/remote/response/student/notification_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.notification,
    this.onTap,
  });

  final NotificationResponse notification;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: notification.isRead ? AppColors.graySoft50 : AppColors.primary25,
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
                      notification.title,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: notification.isRead ? FontWeight.w500 : FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    DateFormat('MMM d').format(notification.createdAt),
                    style: TextStyle(fontSize: 12.sp, color: AppColors.black300),
                  ),
                ],
              ),
              if (notification.body != null && notification.body!.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: Text(
                    notification.body!,
                    style: TextStyle(fontSize: 14.sp, color: AppColors.black500),
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
