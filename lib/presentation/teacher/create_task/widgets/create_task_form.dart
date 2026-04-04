import 'package:eduroom/core/constants/app_colors.dart';
import 'package:eduroom/core/helpers/snackbars/snackbars.dart';
import 'package:eduroom/cubits/teacher_classes/teacher_classes_cubit.dart';
import 'package:eduroom/cubits/teacher_tasks/teacher_tasks_cubit.dart';
import 'package:eduroom/data/models/remote/request/teacher/create_task_params.dart';
import 'package:eduroom/data/models/remote/response/teacher/teacher_class_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CreateTaskForm extends StatefulWidget {
  const CreateTaskForm({super.key, this.selectedClass});

  final TeacherClassResponse? selectedClass;

  @override
  State<CreateTaskForm> createState() => _CreateTaskFormState();
}

class _CreateTaskFormState extends State<CreateTaskForm> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  TeacherClassResponse? _selectedClass;
  DateTime? _dueDate;

  @override
  void initState() {
    super.initState();
    _selectedClass = widget.selectedClass;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_selectedClass == null) {
      Snackbars.showError('Select a class');
      return;
    }
    if (_titleController.text.trim().isEmpty) {
      Snackbars.showError('Enter title');
      return;
    }
    context.read<TeacherTasksCubit>().createTask(CreateTaskParams(
          classId: _selectedClass!.id,
          title: _titleController.text.trim(),
          description: _descController.text.trim().isEmpty ? null : _descController.text.trim(),
          dueAt: _dueDate,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TeacherTasksCubit, TeacherTasksState>(
      listenWhen: (_, s) => s is TeacherTasksSuccess || s is TeacherTasksError,
      listener: (context, state) {
        if (state is TeacherTasksSuccess) {
          Snackbars.showSuccess('Task created');
          if (context.mounted) Navigator.of(context).pop();
        }
      },
      child: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BlocBuilder<TeacherClassesCubit, TeacherClassesState>(
              builder: (context, state) {
                if (state is TeacherClassesSuccess) {
                  final classes = state.classes;
                  return DropdownButtonFormField<TeacherClassResponse>(
                    value: _selectedClass ?? (classes.isNotEmpty ? classes.first : null),
                    decoration: InputDecoration(
                      labelText: 'Class',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                    ),
                    items: classes.map((c) => DropdownMenuItem(value: c, child: Text(c.name))).toList(),
                    onChanged: (v) => setState(() => _selectedClass = v),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            SizedBox(height: 16.h),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
              ),
            ),
            SizedBox(height: 16.h),
            TextField(
              controller: _descController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Description (optional)',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
              ),
            ),
            SizedBox(height: 16.h),
            ListTile(
              title: Text(_dueDate != null ? 'Due: ${_dueDate!.toString().split(' ')[0]}' : 'Due date (optional)'),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (d != null) setState(() => _dueDate = d);
              },
            ),
            SizedBox(height: 32.h),
            BlocBuilder<TeacherTasksCubit, TeacherTasksState>(
              buildWhen: (_, s) => s is TeacherTasksCreating,
              builder: (context, state) {
                final loading = state is TeacherTasksCreating;
                return ElevatedButton(
                  onPressed: loading ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.bgColor,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                  ),
                  child: loading ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('Create'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
