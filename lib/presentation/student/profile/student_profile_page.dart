import 'package:cached_network_image/cached_network_image.dart';
import 'package:eduroom/core/constants/app_colors.dart';
import 'package:eduroom/core/extensions/url_parser_extension.dart';
import 'package:eduroom/core/router/app_routers.dart';
import 'package:eduroom/core/controllers/session_controller.dart';
import 'package:eduroom/data/models/remote/response/profile/student_profile_response.dart';
import 'package:eduroom/presentation/student/profile/widgets/profile_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class StudentProfilePage extends StatelessWidget {
  const StudentProfilePage({super.key, required this.profile});

  final StudentProfileResponse profile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: AppColors.bgColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            CircleAvatar(
              radius: 50.r,
              backgroundColor: AppColors.graySoft100,
              backgroundImage: profile.photoUrl != null && profile.photoUrl!.isNotEmpty
                  ? CachedNetworkImageProvider(profile.photoUrl!.toParsedUrl())
                  : null,
              child: profile.photoUrl == null || profile.photoUrl!.isEmpty
                  ? Icon(Icons.person, size: 50.r, color: AppColors.black300)
                  : null,
            ),
            SizedBox(height: 16.h),
            Text(
              profile.fullName,
              style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
            ),
            if (profile.email.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.email_outlined, size: 18.r, color: AppColors.black500),
                    SizedBox(width: 8.w),
                    Text(profile.email, style: TextStyle(fontSize: 14.sp, color: AppColors.black500)),
                  ],
                ),
              ),
            if (profile.phone != null && profile.phone!.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(top: 4.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.phone_outlined, size: 18.r, color: AppColors.black500),
                    SizedBox(width: 8.w),
                    Text(profile.phone!, style: TextStyle(fontSize: 14.sp, color: AppColors.black500)),
                  ],
                ),
              ),
            SizedBox(height: 24.h),
            ProfileInfoCard(
              title: 'Attendance',
              value: '${profile.attendancePercentage.toStringAsFixed(1)}%',
              icon: Icons.event_available,
            ),
            SizedBox(height: 12.h),
            ProfileInfoCard(
              title: 'Monthly Fee',
              value: '₹${profile.totalMonthlyFee.toStringAsFixed(0)}',
              icon: Icons.payments,
            ),
            if (profile.enrollments.isNotEmpty) ...[
              SizedBox(height: 24.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Enrollments', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
              ),
              SizedBox(height: 12.h),
              ...profile.enrollments.map(
                (e) => Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: AppColors.graySoft50,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: AppColors.graySoft100),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(e.className, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
                        Text(e.courseName, style: TextStyle(fontSize: 14.sp, color: AppColors.black500)),
                        Text(
                          '${DateFormat('MMM y').format(e.startDate)} - ${DateFormat('MMM y').format(e.endDate)}',
                          style: TextStyle(fontSize: 12.sp, color: AppColors.black300),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
            SizedBox(height: 40.h),
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                onPressed: () async {
                  await SessionController.logout();
                  if (context.mounted) {
                    context.go(AppRoutes.login);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.red500,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: const Text('Logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
