import 'package:eduroom/core/constants/app_colors.dart';
import 'package:eduroom/core/helpers/snackbars/snackbars.dart';
import 'package:eduroom/cubits/teacher_task_submissions/teacher_task_submissions_cubit.dart';
import 'package:eduroom/data/models/remote/response/student/task_response.dart';
import 'package:eduroom/presentation/teacher/task_detail/widgets/submission_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TeacherTaskDetailPage extends StatelessWidget {
  const TeacherTaskDetailPage({super.key, required this.task});

  final TaskResponse task;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(task.title),
        backgroundColor: AppColors.bgColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocConsumer<TeacherTaskSubmissionsCubit, TeacherTaskSubmissionsState>(
        listener: (_, state) {
          if (state is TeacherTaskSubmissionsError) {
            Snackbars.showError(state.failure.message ?? 'Error');
          }
        },
        builder: (context, state) {
          if (state is TeacherTaskSubmissionsLoading || state is TeacherTaskSubmissionsInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is TeacherTaskSubmissionsSuccess) {
            final submissions = state.submissions;
            if (submissions.isEmpty) {
              return Center(
                child: Text('No submissions yet', style: TextStyle(fontSize: 16.sp, color: AppColors.black500)),
              );
            }
            return ListView.builder(
              padding: EdgeInsets.all(20.w),
              itemCount: submissions.length,
              itemBuilder: (_, i) => SubmissionCard(
                submission: submissions[i],
                onFeedback: (feedback, status) =>
                    context.read<TeacherTaskSubmissionsCubit>().submitFeedback(submissions[i].id, feedback, status: status),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
