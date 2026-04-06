import 'package:eduroom/core/constants/app_colors.dart';
import 'package:eduroom/core/helpers/snackbars/snackbars.dart';
import 'package:eduroom/cubits/student_notifications/student_notifications_cubit.dart';
import 'package:eduroom/presentation/student/notifications/widgets/notification_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StudentNotificationsPage extends StatelessWidget {
  const StudentNotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: AppColors.bgColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocConsumer<StudentNotificationsCubit, StudentNotificationsState>(
        listener: (_, state) {
          if (state is StudentNotificationsError) {
            Snackbars.showError(state.failure.message ?? 'Error');
          }
        },
        builder: (context, state) {
          if (state is StudentNotificationsLoading || state is StudentNotificationsInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is StudentNotificationsSuccess) {
            final notifications = state.notifications;
            final cubit = context.read<StudentNotificationsCubit>();
            if (notifications.isEmpty) {
              return RefreshIndicator(
                color: Colors.white,
                backgroundColor: AppColors.primaryGradientTop,
                onRefresh: () => cubit.load(),
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    SizedBox(height: 120.h),
                    Center(
                      child: Text(
                        'No notifications',
                        style: TextStyle(fontSize: 16.sp, color: AppColors.black500),
                      ),
                    ),
                  ],
                ),
              );
            }
            return RefreshIndicator(
              color: Colors.white,
              backgroundColor: AppColors.primaryGradientTop,
              onRefresh: () => cubit.load(),
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.all(20.w),
                itemCount: notifications.length,
                itemBuilder: (_, i) {
                  final n = notifications[i];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: NotificationCard(
                      notification: n,
                      onTap: () => cubit.markAsRead(n.id),
                    ),
                  );
                },
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
