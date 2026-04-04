import 'package:eduroom/core/constants/app_colors.dart';
import 'package:eduroom/core/helpers/snackbars/snackbars.dart';
import 'package:eduroom/cubits/teacher_create_task/teacher_create_task_cubit.dart';
import 'package:eduroom/cubits/teacher_tasks/teacher_tasks_cubit.dart';
import 'package:eduroom/presentation/teacher/create_task/widgets/create_task_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeacherCreateTaskPage extends StatelessWidget {
  const TeacherCreateTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TeacherCreateTaskCubit, TeacherCreateTaskState>(
      listenWhen: (prev, curr) {
        if (curr.status == TeacherCreateTaskStatus.success ||
            curr.status == TeacherCreateTaskStatus.taskCreatedFileUploadFailed) {
          return curr.status != prev.status;
        }
        return curr.failure != prev.failure && curr.failure != null;
      },
      listener: (context, state) {
        if (state.status == TeacherCreateTaskStatus.success) {
          context.read<TeacherTasksCubit>().load();
          Snackbars.showSuccess('Task created');
          if (context.mounted) Navigator.of(context).pop();
          return;
        }
        if (state.status == TeacherCreateTaskStatus.taskCreatedFileUploadFailed) {
          context.read<TeacherTasksCubit>().load();
          Snackbars.showError(state.failure?.message ?? 'Task created, but file upload failed');
          if (context.mounted) Navigator.of(context).pop();
          return;
        }
        Snackbars.showError(state.failure?.message ?? 'Error');
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Create Task'),
          backgroundColor: AppColors.bgColor,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        body: const CreateTaskForm(),
      ),
    );
  }
}
