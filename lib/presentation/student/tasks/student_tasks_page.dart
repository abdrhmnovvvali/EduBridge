import 'package:eduroom/core/constants/app_colors.dart';
import 'package:eduroom/core/helpers/snackbars/snackbars.dart';
import 'package:eduroom/cubits/student_tasks/student_tasks_cubit.dart';
import 'package:eduroom/presentation/student/tasks/widgets/task_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StudentTasksPage extends StatelessWidget {
  const StudentTasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Tasks'),
        backgroundColor: AppColors.bgColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocConsumer<StudentTasksCubit, StudentTasksState>(
        listener: (_, state) {
          if (state is StudentTasksError) {
            Snackbars.showError(state.failure.message ?? 'Error');
          }
        },
        builder: (context, state) {
          if (state is StudentTasksLoading || state is StudentTasksInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is StudentTasksSuccess) {
            final tasks = state.tasks;
            if (tasks.isEmpty) {
              return Center(
                child: Text('No tasks yet', style: TextStyle(fontSize: 16.sp, color: AppColors.black500)),
              );
            }
            return ListView.builder(
              padding: EdgeInsets.all(20.w),
              itemCount: tasks.length,
              itemBuilder: (_, i) => TaskCard(task: tasks[i]),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
