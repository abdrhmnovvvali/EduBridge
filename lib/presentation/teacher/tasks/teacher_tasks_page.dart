import 'package:eduroom/core/constants/app_colors.dart';
import 'package:eduroom/core/helpers/snackbars/snackbars.dart';
import 'package:eduroom/core/router/app_routers.dart';
import 'package:eduroom/cubits/teacher_tasks/teacher_tasks_cubit.dart';
import 'package:eduroom/presentation/student/tasks/widgets/task_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class TeacherTasksPage extends StatelessWidget {
  const TeacherTasksPage({super.key});

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
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(AppRoutes.teacherCreateTask),
        backgroundColor: AppColors.bgColor,
        child: const Icon(Icons.add),
      ),
      body: BlocConsumer<TeacherTasksCubit, TeacherTasksState>(
        listener: (_, state) {
          if (state is TeacherTasksError) {
            Snackbars.showError(state.failure.message ?? 'Error');
          }
        },
        builder: (context, state) {
          if (state is TeacherTasksLoading || state is TeacherTasksInitial || state is TeacherTasksCreating) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is TeacherTasksSuccess) {
            final tasks = state.tasks;
            if (tasks.isEmpty) {
              return Center(
                child: Text('No tasks yet', style: TextStyle(fontSize: 16.sp, color: AppColors.black500)),
              );
            }
            return ListView.builder(
              padding: EdgeInsets.all(20.w),
              itemCount: tasks.length,
              itemBuilder: (_, i) => GestureDetector(
                onTap: () => context.push(AppRoutes.teacherTaskDetail, extra: tasks[i]),
                child: TaskCard(task: tasks[i]),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
