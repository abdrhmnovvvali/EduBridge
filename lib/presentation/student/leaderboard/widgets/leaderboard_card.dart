import 'package:eduroom/core/constants/app_colors.dart';
import 'package:eduroom/data/models/remote/response/student/leaderboard_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LeaderboardCard extends StatelessWidget {
  const LeaderboardCard({super.key, required this.item});

  final LeaderboardItem item;

  IconData get _medalIcon {
    switch (item.rank) {
      case 1:
        return Icons.emoji_events;
      case 2:
        return Icons.workspace_premium;
      case 3:
        return Icons.military_tech;
      default:
        return Icons.person;
    }
  }

  Color get _medalColor {
    switch (item.rank) {
      case 1:
        return const Color(0xFFFFD700);
      case 2:
        return const Color(0xFFC0C0C0);
      case 3:
        return const Color(0xFFCD7F32);
      default:
        return AppColors.bgColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: item.rank <= 3 ? AppColors.primary25 : AppColors.graySoft50,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: item.rank <= 3 ? AppColors.primary400 : AppColors.graySoft100),
      ),
      child: Row(
        children: [
          Icon(_medalIcon, size: 32.r, color: _medalColor),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('#${item.rank}', style: TextStyle(fontSize: 12.sp, color: AppColors.black300)),
                Text(item.studentName, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(color: AppColors.bgColor, borderRadius: BorderRadius.circular(8.r)),
            child: Text(item.value.toStringAsFixed(1), style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
