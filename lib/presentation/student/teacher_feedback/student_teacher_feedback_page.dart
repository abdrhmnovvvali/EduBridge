import 'package:eduroom/core/constants/app_colors.dart';
import 'package:eduroom/core/helpers/snackbars/snackbars.dart';
import 'package:eduroom/cubits/student_teacher_feedback/student_teacher_feedback_cubit.dart';
import 'package:eduroom/data/models/remote/response/profile/student_profile_response.dart';
import 'package:eduroom/presentation/student/teacher_feedback/widgets/teacher_feedback_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StudentTeacherFeedbackPage extends StatelessWidget {
  const StudentTeacherFeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Teacher feedback'),
        backgroundColor: AppColors.bgColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body:
          BlocConsumer<
            StudentTeacherFeedbackCubit,
            StudentTeacherFeedbackState
          >(
            listenWhen: (prev, curr) =>
                curr.failure != null && curr.failure != prev.failure,
            listener: (context, state) {
              Snackbars.showError(state.failure!.message ?? 'Error');
            },
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 8.h),
                    child: _ClassFilterDropdown(
                      enrollments: state.enrollments,
                      selectedClassId: state.selectedClassId,
                      onChanged: (id) => context
                          .read<StudentTeacherFeedbackCubit>()
                          .setClassFilter(id),
                    ),
                  ),
                  Expanded(
                    child: state.isLoading && state.items.isEmpty
                        ? const Center(child: CircularProgressIndicator())
                        : state.items.isEmpty
                        ? RefreshIndicator(
                            onRefresh: () => context
                                .read<StudentTeacherFeedbackCubit>()
                                .load(),
                            child: ListView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              children: [
                                SizedBox(height: 120.h),
                                Center(
                                  child: Text(
                                    'No teacher feedback yet',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: AppColors.black500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : RefreshIndicator(
                            onRefresh: () => context
                                .read<StudentTeacherFeedbackCubit>()
                                .load(),
                            child: NotificationListener<ScrollNotification>(
                              onNotification: (n) {
                                if (n.metrics.pixels >=
                                    n.metrics.maxScrollExtent - 120) {
                                  context
                                      .read<StudentTeacherFeedbackCubit>()
                                      .loadMore();
                                }
                                return false;
                              },
                              child: ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(),
                                padding: EdgeInsets.fromLTRB(
                                  20.w,
                                  0,
                                  20.w,
                                  24.h,
                                ),
                                itemCount:
                                    state.items.length +
                                    (state.isLoadingMore ? 1 : 0),
                                itemBuilder: (context, i) {
                                  if (i >= state.items.length) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 16.h,
                                      ),
                                      child: const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  }
                                  return TeacherFeedbackCard(
                                    item: state.items[i],
                                  );
                                },
                              ),
                            ),
                          ),
                  ),
                ],
              );
            },
          ),
    );
  }
}

class _ClassFilterDropdown extends StatelessWidget {
  const _ClassFilterDropdown({
    required this.enrollments,
    required this.selectedClassId,
    required this.onChanged,
  });

  final List<Enrollment> enrollments;
  final int? selectedClassId;
  final void Function(int?) onChanged;

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: 'Class',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int?>(
          isExpanded: true,
          value: selectedClassId,
          items: [
            const DropdownMenuItem<int?>(
              value: null,
              child: Text('All classes'),
            ),
            ...enrollments.map(
              (e) => DropdownMenuItem<int?>(
                value: e.classId,
                child: Text(e.className),
              ),
            ),
          ],
          onChanged: onChanged,
        ),
      ),
    );
  }
}
