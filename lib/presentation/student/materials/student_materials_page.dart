import 'package:eduroom/core/constants/app_colors.dart';
import 'package:eduroom/core/helpers/snackbars/snackbars.dart';
import 'package:eduroom/cubits/student_materials/student_materials_cubit.dart';
import 'package:eduroom/presentation/student/materials/widgets/material_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StudentMaterialsPage extends StatelessWidget {
  const StudentMaterialsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Materials'),
        backgroundColor: AppColors.bgColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocConsumer<StudentMaterialsCubit, StudentMaterialsState>(
        listener: (_, state) {
          if (state is StudentMaterialsError) {
            Snackbars.showError(state.failure.message ?? 'Error');
          }
        },
        builder: (context, state) {
          if (state is StudentMaterialsLoading || state is StudentMaterialsInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is StudentMaterialsSuccess) {
            final materials = state.materials;
            if (materials.isEmpty) {
              return Center(
                child: Text('No materials yet', style: TextStyle(fontSize: 16.sp, color: AppColors.black500)),
              );
            }
            return ListView.builder(
              padding: EdgeInsets.all(20.w),
              itemCount: materials.length,
              itemBuilder: (_, i) => MaterialCard(material: materials[i]),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
