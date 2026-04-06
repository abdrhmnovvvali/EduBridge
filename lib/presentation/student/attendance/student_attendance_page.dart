import 'package:eduroom/core/constants/app_colors.dart';
import 'package:eduroom/core/helpers/snackbars/snackbars.dart';
import 'package:eduroom/cubits/student_attendance/student_attendance_cubit.dart';
import 'package:eduroom/data/models/remote/response/student/attendance_response.dart';
import 'package:eduroom/presentation/student/attendance/widgets/attendance_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class StudentAttendancePage extends StatefulWidget {
  const StudentAttendancePage({super.key});

  @override
  State<StudentAttendancePage> createState() => _StudentAttendancePageState();
}

class _StudentAttendancePageState extends State<StudentAttendancePage> {
  DateTime _focusedMonth = DateTime.now();

  /// Hər təqvim günü üçün: hər hansı `present`/`late` qeyd varsa yaşıl, yalnız absent-dirsə qırmızı.
  ({Set<DateTime> presentDates, Set<DateTime> absentDates}) _calendarDaySets(
    List<AttendanceResponse> items,
  ) {
    final byDay = <DateTime, List<String>>{};
    for (final e in items) {
      final d = e.sessionDate;
      if (d == null) continue;
      final key = DateTime(d.year, d.month, d.day);
      byDay.putIfAbsent(key, () => []).add(e.status);
    }
    final present = <DateTime>{};
    final absent = <DateTime>{};
    for (final entry in byDay.entries) {
      var anyPresent = false;
      var anyAbsent = false;
      for (final raw in entry.value) {
        final s = raw.trim().toLowerCase();
        if (s == 'present' || s == 'late') anyPresent = true;
        if (s == 'absent') anyAbsent = true;
      }
      if (anyPresent) {
        present.add(entry.key);
      } else if (anyAbsent) {
        absent.add(entry.key);
      }
    }
    return (presentDates: present, absentDates: absent);
  }

  int _countInMonth(Set<DateTime> dates, DateTime month) {
    return dates
        .where((d) => d.year == month.year && d.month == month.month)
        .length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.graySoft50,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              height: 180.h,
              decoration: BoxDecoration(gradient: AppColors.primary),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 16.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.white,
                              size: 20,
                            ),
                            onPressed: () => context.pop(),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                'ATTENDANCE',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 40.w),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 24.h)),
          SliverToBoxAdapter(
            child: BlocConsumer<StudentAttendanceCubit, StudentAttendanceState>(
              listener: (_, state) {
                if (state is StudentAttendanceError) {
                  Snackbars.showError(state.failure.message ?? 'Error');
                }
              },
              builder: (context, state) {
                if (state is StudentAttendanceLoading ||
                    state is StudentAttendanceInitial) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Container(
                      height: 320.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                  );
                }
                if (state is StudentAttendanceSuccess) {
                  final sets = _calendarDaySets(state.items);
                  final presentCount = _countInMonth(
                    sets.presentDates,
                    _focusedMonth,
                  );
                  final absentMonthCount = _countInMonth(
                    sets.absentDates,
                    _focusedMonth,
                  );

                  return Column(
                    children: [
                      AttendanceCalendar(
                        focusedMonth: _focusedMonth,
                        onMonthChanged: (d) =>
                            setState(() => _focusedMonth = d),
                        absentDates: sets.absentDates,
                        presentDates: sets.presentDates,
                      ),
                      SizedBox(height: 30.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Row(
                          children: [
                            Expanded(
                              child: _LegendChip(
                                label: 'Absent',
                                count: absentMonthCount,
                                color: AppColors.red500,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: _LegendChip(
                                label: 'Present',
                                count: presentCount,
                                color: AppColors.presentGreen,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Spacer(),
                      // _buildBottomIllustration(),
                      70.verticalSpace,
                      SvgPicture.asset("assets/svg/attendance.svg"),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _LegendChip extends StatelessWidget {
  const _LegendChip({
    required this.label,
    required this.count,
    required this.color,
  });

  final String label;
  final int count;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 12.w),
          Container(
            width: 26.w,
            height: 26.w,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text(
              count.toString().padLeft(2, '0'),
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
