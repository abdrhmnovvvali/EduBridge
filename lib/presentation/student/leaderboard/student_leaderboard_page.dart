import 'package:eduroom/core/constants/app_colors.dart';
import 'package:eduroom/core/helpers/snackbars/snackbars.dart';
import 'package:eduroom/cubits/student_leaderboard/student_leaderboard_cubit.dart';
import 'package:eduroom/presentation/student/leaderboard/widgets/leaderboard_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StudentLeaderboardPage extends StatelessWidget {
  const StudentLeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Leaderboard'),
        backgroundColor: AppColors.bgColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocConsumer<StudentLeaderboardCubit, StudentLeaderboardState>(
        listener: (_, state) {
          if (state is StudentLeaderboardError) {
            Snackbars.showError(state.failure.message ?? 'Error');
          }
        },
        builder: (context, state) {
          if (state is StudentLeaderboardLoading || state is StudentLeaderboardInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is StudentLeaderboardSuccess) {
            final items = state.data.items;
            if (items.isEmpty) {
              return Center(
                child: Text('No leaderboard data yet', style: TextStyle(fontSize: 16.sp, color: AppColors.black500)),
              );
            }
            return ListView.builder(
              padding: EdgeInsets.all(20.w),
              itemCount: items.length,
              itemBuilder: (_, i) => LeaderboardCard(item: items[i]),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
