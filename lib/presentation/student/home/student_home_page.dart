import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:eduroom/core/constants/app_assets.dart';
import 'package:eduroom/core/constants/app_colors.dart';
import 'package:eduroom/core/extensions/url_parser_extension.dart';
import 'package:eduroom/core/router/app_routers.dart';
import 'package:eduroom/presentation/student/home/widgets/student_text_skeleton.dart';
import 'package:eduroom/presentation/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../cubits/student_profile/student_profile_cubit.dart';

class StudentHomePage extends StatelessWidget {
  const StudentHomePage({super.key});

  Future<void> _onRefresh(BuildContext context) async {
    final cubit = context.read<StudentProfileCubit>();
    final done = cubit.stream
        .firstWhere(
          (s) =>
              s is StudentProfileSuccess ||
              s is StudentProfileError ||
              s is StudentProfileNetworkError,
        )
        .timeout(const Duration(seconds: 25));
    cubit.getStudentProfile();
    try {
      await done;
    } on TimeoutException {
      // sessiya davam etsin
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: RefreshIndicator(
        color: Colors.white,
        backgroundColor: AppColors.primaryGradientTop,
        displacement: 48,
        onRefresh: () => _onRefresh(context),
        child: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 334.h,
              child: BlocBuilder<StudentProfileCubit, StudentProfileState>(
                builder: (_, state) {
                  if (state is StudentProfileLoading || state is StudentProfileInitial) {
                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: 334.h,
                          decoration: BoxDecoration(
                            gradient: AppColors.primary,
                          ),
                        ),
                        Positioned(
                          top: 300.h,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.r),
                                topRight: Radius.circular(30.r),
                              ),
                            ),
                          ),
                        ),
                        const StudentTextSkeleton(),
                      ],
                    );
                  } else if (state is StudentProfileSuccess) {
                    final studentProfile = state.data;
                    final enrollment = studentProfile.enrollments.isNotEmpty
                        ? studentProfile.enrollments.first
                        : null;
                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: 334.h,
                          decoration: BoxDecoration(
                            gradient: AppColors.primary,
                          ),
                        ),
                        Positioned(
                          top: 300.h,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.r),
                                topRight: Radius.circular(30.r),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 70.h,
                          left: 20.w,
                          right: 20.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    studentProfile.fullName,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    enrollment?.className ?? '—',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  SizedBox(height: 12.h),
                                  if (enrollment != null)
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12.w,
                                        vertical: 6.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20.r),
                                      ),
                                      child: Text(
                                        "${enrollment.startDate.month.toString().padLeft(2, '0')}.${enrollment.startDate.year} - "
                                        "${enrollment.endDate.month.toString().padLeft(2, '0')}.${enrollment.endDate.year}",
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () => context.push(
                                  AppRoutes.studentProfile,
                                  extra: studentProfile,
                                ),
                                child: CircleAvatar(
                                  radius: 30.r,
                                  backgroundColor: Colors.grey[300],
                                  child: studentProfile.photoUrl != null &&
                                          studentProfile.photoUrl!.isNotEmpty
                                      ? CachedNetworkImage(
                                          imageUrl: studentProfile.photoUrl!
                                              .toParsedUrl(),
                                        )
                                      : Icon(Icons.person, size: 30.r),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned( top: 165.h, left: 20.w, child: Image.asset( AppAssets.stars, width: 333.w, height: 62.h, ), ),
                        Positioned(
                          top: 200.h,
                          left: 20.w,
                          right: 20.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomCard(
                                color: Colors.white,
                                top: 31.h,
                                asset: AppAssets.stundent,
                                value:
                                    "${studentProfile.attendancePercentage.toStringAsFixed(0)}%",
                                label: "Attendance",
                              ),
                              CustomCard(
                                color: Colors.white,
                                top: 31.h,
                                asset: AppAssets.fee,
                                value:
                                    "${studentProfile.totalMonthlyFee.toStringAsFixed(0)}₼",
                                label: "Fees Due",
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 70.h)),

          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate((context, index) {
                final items = [
                  (label: 'Tasks', icon: Icons.assignment, route: AppRoutes.studentTasks),
                  (label: 'Materials', icon: Icons.folder_open, route: AppRoutes.studentMaterials),
                  (label: 'Feedback', icon: Icons.rate_review, route: AppRoutes.studentTeacherFeedback),
                  (label: 'Attendance', icon: Icons.event_available, route: AppRoutes.studentAttendance),
                  (label: 'Grades', icon: Icons.grade, route: AppRoutes.studentGrades),
                  (label: 'Invoices', icon: Icons.receipt_long, route: AppRoutes.studentInvoices),
                  (label: 'Notifications', icon: Icons.notifications, route: AppRoutes.studentNotifications),
                  (label: 'Leaderboard', icon: Icons.emoji_events, route: AppRoutes.studentLeaderboard),
                ];
                final item = items[index];
                return GestureDetector(
                  onTap: () => context.push(item.route),
                  child: Container(
                    height: 132.h,
                    width: 163.w,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(item.icon, size: 40.r, color: AppColors.bgColor),
                        SizedBox(height: 8.h),
                        Text(item.label, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                );
              }, childCount: 8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15.h,
                crossAxisSpacing: 15.w,
                childAspectRatio: 1,
              ),
            ),
          ),
        ],
        ),
      ),
    );
  }
}
