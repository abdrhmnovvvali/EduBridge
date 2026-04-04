import 'package:eduroom/core/constants/app_colors.dart';
import 'package:eduroom/data/models/remote/response/teacher/teacher_session_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class SessionInfoCard extends StatelessWidget {
  const SessionInfoCard({super.key, required this.session});

  final TeacherSessionResponse session;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.graySoft50,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.graySoft100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${DateFormat('MMM d, y').format(session.startsAt)}', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
          Text('${DateFormat('HH:mm').format(session.startsAt)} - ${DateFormat('HH:mm').format(session.endsAt)}', style: TextStyle(fontSize: 14.sp, color: AppColors.black500)),
          Text('Status: ${session.status}', style: TextStyle(fontSize: 12.sp, color: AppColors.black300)),
        ],
      ),
    );
  }
}
