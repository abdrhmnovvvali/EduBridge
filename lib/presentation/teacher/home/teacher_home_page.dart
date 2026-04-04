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

import '../../../cubits/teacher_profile/teacher_profile_cubit.dart';

class TeacherHomePage extends StatelessWidget {
  const TeacherHomePage({super.key});

  Future<void> _onRefresh(BuildContext context) async {
    final cubit = context.read<TeacherProfileCubit>();
    final done = cubit.stream
        .firstWhere(
          (s) =>
              s is TeacherProfileSuccess ||
              s is TeacherProfileError ||
              s is TeacherProfileNetworkError,
        )
        .timeout(const Duration(seconds: 25));
    cubit.getTeacherProfile();
    try {
      await done;
    } on TimeoutException {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryGradientTop,
      body: RefreshIndicator(
        color: Colors.white,
        backgroundColor: AppColors.primaryGradientTop,
        displacement: 48,
        onRefresh: () => _onRefresh(context),
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 334.h,
              child: BlocBuilder<TeacherProfileCubit, TeacherProfileState>(
                builder: (_, state) {
                  if (state is TeacherProfileLoading ||
                      state is TeacherProfileInitial) {
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
                  } else if (state is TeacherProfileSuccess) {
                    final teacherProfile = state.data;

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
                                    teacherProfile.fullName,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    teacherProfile.course?.courseName ?? '—',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  if (teacherProfile.course != null) ...[
                                    SizedBox(height: 12.h),
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
                                        "${teacherProfile.course!.startDate.month.toString().padLeft(2, '0')}.${teacherProfile.course!.startDate.year}-"
                                        "${teacherProfile.course!.endDate.month.toString().padLeft(2, '0')}.${teacherProfile.course!.endDate.year}",
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              GestureDetector(
                                onTap: () => context.push(
                                  AppRoutes.teacherProfile,
                                  extra: teacherProfile,
                                ),
                                child: CircleAvatar(
                                  radius: 30.r,
                                  backgroundColor: Colors.grey[300],
                                  backgroundImage:
                                      teacherProfile.photoUrl != null &&
                                          teacherProfile.photoUrl!.isNotEmpty
                                      ? CachedNetworkImageProvider(
                                          teacherProfile.photoUrl!.toParsedUrl(),
                                        )
                                      : null,
                                  child:
                                      teacherProfile.photoUrl == null ||
                                          teacherProfile.photoUrl!.isEmpty
                                      ? Icon(Icons.person, size: 30.r)
                                      : null,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 165.h,
                          left: 20.w,
                          child: Image.asset(
                            AppAssets.stars,
                            width: 333.w,
                            height: 62.h,
                          ),
                        ),
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
                                value: "%",
                                label: "Attendance",
                              ),
                              CustomCard(
                                color: Colors.white,
                                top: 31.h,
                                asset: AppAssets.fee,
                                value: "₹",
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
                  (label: 'Classes', icon: Icons.class_, route: AppRoutes.teacherClasses),
                  (label: 'Tasks', icon: Icons.assignment, route: AppRoutes.teacherTasks),
                  (label: 'Materials', icon: Icons.folder_open, route: AppRoutes.teacherMaterials),
                  (label: 'Grades', icon: Icons.grade, route: AppRoutes.teacherGrades),
                  (label: 'Attendance', icon: Icons.event_available, route: AppRoutes.teacherClasses),
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
              }, childCount: 5),
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
