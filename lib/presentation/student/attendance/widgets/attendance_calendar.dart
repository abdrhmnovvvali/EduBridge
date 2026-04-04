import 'package:eduroom/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class AttendanceCalendar extends StatelessWidget {
  const AttendanceCalendar({
    super.key,
    required this.focusedMonth,
    required this.onMonthChanged,
    required this.absentDates,
    required this.presentDates,
  });

  final DateTime focusedMonth;
  final ValueChanged<DateTime> onMonthChanged;
  final Set<DateTime> absentDates;
  final Set<DateTime> presentDates;

  Widget _dayCell(DateTime date, {required bool isOutside}) {
    final d = DateTime(date.year, date.month, date.day);
    final isAbsent = !isOutside &&
        absentDates.any((x) => x.year == d.year && x.month == d.month && x.day == d.day);
    final isPresent = !isOutside &&
        presentDates.any((x) => x.year == d.year && x.month == d.month && x.day == d.day);
    Color? bgColor;
    if (isAbsent) {
      bgColor = AppColors.red500;
    } else if (isPresent) {
      bgColor = AppColors.presentGreen;
    } else if (!isOutside && date.weekday == DateTime.sunday) {
      bgColor = AppColors.graySoft25.withOpacity(0.25);
    }
    final coloredDay = isAbsent || isPresent;
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        '${date.day}',
        style: TextStyle(
          fontSize: 13.sp,
          color: isOutside
              ? AppColors.black300
              : (coloredDay ? Colors.white : AppColors.black900),
          fontWeight: coloredDay ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400.w,
      height: 380.h,
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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () => onMonthChanged(DateTime(focusedMonth.year, focusedMonth.month - 1)),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              Text(
                DateFormat('MMMM yyyy').format(focusedMonth).toUpperCase(),
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: AppColors.black900),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: () => onMonthChanged(DateTime(focusedMonth.year, focusedMonth.month + 1)),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          TableCalendar(
            firstDay: DateTime(2020, 1, 1),
            lastDay: DateTime(2030, 12, 31),
            focusedDay: focusedMonth,
            calendarFormat: CalendarFormat.month,
            startingDayOfWeek: StartingDayOfWeek.monday,
            headerVisible: false,
            onPageChanged: onMonthChanged,
            calendarStyle: CalendarStyle(
              outsideDaysVisible: true,
              outsideTextStyle: TextStyle(fontSize: 12.sp, color: AppColors.black300),
              defaultTextStyle: TextStyle(fontSize: 13.sp, color: AppColors.black900),
              weekendTextStyle: TextStyle(fontSize: 13.sp, color: AppColors.graySoft25),
              markerDecoration: BoxDecoration(
                color: AppColors.graySoft25.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              // Gün rəngləri tam calendarBuilders ilə (present=yaşıl) idarə olunur.
              todayDecoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.transparent),
              todayTextStyle: const TextStyle(color: Colors.transparent),
              selectedDecoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.transparent),
              selectedTextStyle: const TextStyle(color: Colors.transparent),
            ),
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, date, events) {
                final d = DateTime(date.year, date.month, date.day);
                final isAbsent = absentDates.any((x) => x.year == d.year && x.month == d.month && x.day == d.day);
                final isPresent = presentDates.any((x) => x.year == d.year && x.month == d.month && x.day == d.day);
                if (isAbsent) {
                  return Positioned(
                    bottom: 2,
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(color: AppColors.red500, shape: BoxShape.circle),
                    ),
                  );
                }
                if (isPresent) {
                  return Positioned(
                    bottom: 2,
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(color: AppColors.presentGreen, shape: BoxShape.circle),
                    ),
                  );
                }
                return null;
              },
              defaultBuilder: (context, date, _) =>
                  _dayCell(date, isOutside: date.month != focusedMonth.month),
              todayBuilder: (context, date, _) =>
                  _dayCell(date, isOutside: date.month != focusedMonth.month),
              selectedBuilder: (context, date, _) =>
                  _dayCell(date, isOutside: date.month != focusedMonth.month),
              outsideBuilder: (context, date, _) => _dayCell(date, isOutside: true),
            ),
          ),
        ],
      ),
    );
  }
}
