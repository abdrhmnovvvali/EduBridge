import 'package:eduroom/core/constants/app_colors.dart';
import 'package:eduroom/core/helpers/snackbars/snackbars.dart';
import 'package:eduroom/core/router/app_routers.dart';
import 'package:eduroom/cubits/teacher_materials_list/teacher_materials_list_cubit.dart';
import 'package:eduroom/data/models/remote/response/teacher/teacher_class_response.dart';
import 'package:eduroom/presentation/student/materials/widgets/material_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class TeacherMaterialsPage extends StatelessWidget {
  const TeacherMaterialsPage({super.key, this.selectedClass});

  final TeacherClassResponse? selectedClass;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Files'),
        backgroundColor: AppColors.bgColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            tooltip: 'Add link',
            icon: const Icon(Icons.link),
            onPressed: () async {
              await context.push(AppRoutes.teacherLinkMaterial, extra: selectedClass);
              if (context.mounted) {
                context.read<TeacherMaterialsListCubit>().load();
              }
            },
          ),
        ],
      ),
      body: BlocConsumer<TeacherMaterialsListCubit, TeacherMaterialsListState>(
        listener: (_, state) {
          if (state is TeacherMaterialsListError) {
            Snackbars.showError(state.failure.message ?? 'Error');
          }
        },
        builder: (context, state) {
          if (state is TeacherMaterialsListLoading || state is TeacherMaterialsListInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is TeacherMaterialsListSuccess) {
            final materials = state.materials;
            if (materials.isEmpty) {
              return RefreshIndicator(
                onRefresh: () => context.read<TeacherMaterialsListCubit>().load(),
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    SizedBox(height: 120.h),
                    Center(
                      child: Text(
                        'No file materials yet',
                        style: TextStyle(fontSize: 16.sp, color: AppColors.black500),
                      ),
                    ),
                  ],
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: () => context.read<TeacherMaterialsListCubit>().load(),
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.all(20.w),
                itemCount: materials.length,
                itemBuilder: (_, i) => MaterialCard(material: materials[i]),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
