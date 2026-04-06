import 'package:eduroom/core/constants/app_colors.dart';
import 'package:eduroom/core/helpers/snackbars/snackbars.dart';
import 'package:eduroom/cubits/student_grades/student_grades_cubit.dart';
import 'package:eduroom/presentation/student/grades/widgets/grade_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StudentGradesPage extends StatelessWidget {
  const StudentGradesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Grades'),
        backgroundColor: AppColors.bgColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocConsumer<StudentGradesCubit, StudentGradesState>(
        listener: (_, state) {
          if (state is StudentGradesError) {
            Snackbars.showError(state.failure.message ?? 'Error');
          }
        },
        builder: (context, state) {
          if (state is StudentGradesLoading || state is StudentGradesInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is StudentGradesSuccess) {
            final grades = state.grades;
            if (grades.isEmpty) {
              return Center(
                child: Text(
                  'No grades yet',
                  style: TextStyle(fontSize: 16.sp, color: AppColors.black500),
                ),
              );
            }
            return ListView.builder(
              padding: EdgeInsets.all(20.w),
              itemCount: grades.length,
              itemBuilder: (_, i) => GradeCard(grade: grades[i]),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
