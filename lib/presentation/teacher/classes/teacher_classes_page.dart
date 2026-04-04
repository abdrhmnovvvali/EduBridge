import 'package:eduroom/core/constants/app_colors.dart';
import 'package:eduroom/core/helpers/snackbars/snackbars.dart';
import 'package:eduroom/core/router/app_routers.dart';
import 'package:eduroom/cubits/teacher_classes/teacher_classes_cubit.dart';
import 'package:eduroom/presentation/teacher/classes/widgets/teacher_class_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class TeacherClassesPage extends StatelessWidget {
  const TeacherClassesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Classes'),
        backgroundColor: AppColors.bgColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocConsumer<TeacherClassesCubit, TeacherClassesState>(
        listener: (_, state) {
          if (state is TeacherClassesError) {
            Snackbars.showError(state.failure.message ?? 'Error');
          }
        },
        builder: (context, state) {
          if (state is TeacherClassesLoading || state is TeacherClassesInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is TeacherClassesSuccess) {
            final classes = state.classes;
            if (classes.isEmpty) {
              return Center(
                child: Text('No classes yet', style: TextStyle(fontSize: 16.sp, color: AppColors.black500)),
              );
            }
            return ListView.builder(
              padding: EdgeInsets.all(20.w),
              itemCount: classes.length,
              itemBuilder: (_, i) => GestureDetector(
                onTap: () => context.push(AppRoutes.teacherClassDetail, extra: classes[i]),
                child: TeacherClassCard(clazz: classes[i]),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
