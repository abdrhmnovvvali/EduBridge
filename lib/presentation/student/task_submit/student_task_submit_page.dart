import 'package:eduroom/core/constants/app_colors.dart';
import 'package:eduroom/core/helpers/snackbars/snackbars.dart';
import 'package:eduroom/cubits/student_task_submit/student_task_submit_cubit.dart';
import 'package:eduroom/data/models/remote/response/student/task_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class StudentTaskSubmitPage extends StatelessWidget {
  const StudentTaskSubmitPage({super.key, required this.task});

  final TaskResponse task;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentTaskSubmitCubit, StudentTaskSubmitState>(
      listenWhen: (p, c) =>
          c.status != p.status || (c.failure != null && c.failure != p.failure),
      listener: (context, state) {
        if (state.status == StudentTaskSubmitStatus.success) {
          Snackbars.showSuccess('Submitted');
          if (context.mounted) context.pop(true);
          return;
        }
        if (state.failure != null) {
          Snackbars.showError(state.failure!.message ?? 'Error');
        }
      },
      builder: (context, state) {
        final cubit = context.read<StudentTaskSubmitCubit>();
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text('Submit work'),
            backgroundColor: AppColors.bgColor,
            foregroundColor: Colors.white,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  task.title,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (task.description != null &&
                    task.description!.isNotEmpty) ...[
                  SizedBox(height: 12.h),
                  Text(
                    task.description!,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.black500,
                    ),
                  ),
                ],
                if (task.dueAt != null) ...[
                  SizedBox(height: 8.h),
                  Text(
                    'Due: ${DateFormat('MMM d, y').format(task.dueAt!)}',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: AppColors.black300,
                    ),
                  ),
                ],
                if (task.className != null) ...[
                  SizedBox(height: 4.h),
                  Text(
                    task.className!,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: AppColors.graySoft25,
                    ),
                  ),
                ],
                SizedBox(height: 24.h),
                TextField(
                  controller: cubit.commentController,
                  enabled: !state.isSubmitting,
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: 'Your answer / notes',
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                OutlinedButton.icon(
                  onPressed: state.isSubmitting ? null : () => cubit.pickFile(),
                  icon: const Icon(Icons.attach_file),
                  label: Text(state.pickedFileName ?? 'Attach file (optional)'),
                ),
                if (state.pickedFilePath != null) ...[
                  SizedBox(height: 8.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      onPressed: state.isSubmitting
                          ? null
                          : () => cubit.clearPickedFile(),
                      icon: const Icon(Icons.close, size: 18),
                      label: const Text('Remove file'),
                    ),
                  ),
                ],
                SizedBox(height: 24.h),
                ElevatedButton(
                  onPressed: state.isSubmitting ? null : () => cubit.submit(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.bgColor,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: state.isSubmitting
                      ? SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text('Submit'),
                ),
                SizedBox(height: 12.h),
                Text(
                  'You can write a comment, attach a file, or both.',
                  style: TextStyle(fontSize: 12.sp, color: AppColors.black300),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
