import 'package:eduroom/core/constants/app_colors.dart';
import 'package:eduroom/cubits/teacher_classes/teacher_classes_cubit.dart';
import 'package:eduroom/cubits/teacher_create_task/teacher_create_task_cubit.dart';
import 'package:eduroom/data/models/remote/response/teacher/teacher_class_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateTaskForm extends StatelessWidget {
  const CreateTaskForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TeacherCreateTaskCubit>();

    return BlocListener<TeacherClassesCubit, TeacherClassesState>(
      listenWhen: (p, c) => c is TeacherClassesSuccess && p is! TeacherClassesSuccess,
      listener: (context, state) {
        if (state is TeacherClassesSuccess && state.classes.isNotEmpty) {
          context.read<TeacherCreateTaskCubit>().ensureDefaultClass(state.classes);
        }
      },
      child: BlocBuilder<TeacherCreateTaskCubit, TeacherCreateTaskState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BlocBuilder<TeacherClassesCubit, TeacherClassesState>(
                  builder: (context, classesState) {
                    if (classesState is TeacherClassesSuccess) {
                      final classes = classesState.classes;
                      return DropdownButtonFormField<TeacherClassResponse>(
                        value: state.selectedClass ?? (classes.isNotEmpty ? classes.first : null),
                        decoration: InputDecoration(
                          labelText: 'Class',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                        ),
                        items: classes.map((c) => DropdownMenuItem(value: c, child: Text(c.name))).toList(),
                        onChanged: state.isSubmitting ? null : (v) => cubit.setSelectedClass(v),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                SizedBox(height: 16.h),
                TextField(
                  controller: cubit.titleController,
                  enabled: !state.isSubmitting,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                  ),
                ),
                SizedBox(height: 16.h),
                TextField(
                  controller: cubit.descriptionController,
                  enabled: !state.isSubmitting,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Description (optional)',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                  ),
                ),
                SizedBox(height: 16.h),
                ListTile(
                  title: Text(
                    state.dueDate != null
                        ? 'Due: ${state.dueDate!.toString().split(' ')[0]}'
                        : 'Due date (optional)',
                  ),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: state.isSubmitting
                      ? null
                      : () async {
                          final d = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(const Duration(days: 365)),
                          );
                          if (d != null && context.mounted) {
                            context.read<TeacherCreateTaskCubit>().setDueDate(d);
                          }
                        },
                ),
                SizedBox(height: 8.h),
                OutlinedButton.icon(
                  onPressed: state.isSubmitting ? null : () => cubit.pickFile(),
                  icon: const Icon(Icons.attach_file),
                  label: Text(state.pickedFileName ?? 'Attach material file (optional)'),
                ),
                if (state.pickedFilePath != null) ...[
                  SizedBox(height: 8.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      onPressed: state.isSubmitting ? null : () => cubit.clearPickedFile(),
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
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                  ),
                  child: state.isSubmitting
                      ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Text('Create'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
