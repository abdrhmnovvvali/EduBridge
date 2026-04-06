import 'package:eduroom/core/constants/app_colors.dart';
import 'package:eduroom/core/helpers/snackbars/snackbars.dart';
import 'package:eduroom/cubits/teacher_classes/teacher_classes_cubit.dart';
import 'package:eduroom/cubits/teacher_class_students/teacher_class_students_cubit.dart';
import 'package:eduroom/cubits/teacher_grades/teacher_grades_cubit.dart';
import 'package:eduroom/data/models/remote/request/teacher/upsert_grade_params.dart';
import 'package:eduroom/data/models/remote/response/teacher/teacher_class_response.dart';
import 'package:eduroom/data/models/remote/response/teacher/teacher_class_student_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GradesForm extends StatefulWidget {
  const GradesForm({super.key, this.selectedClass});

  final TeacherClassResponse? selectedClass;

  @override
  State<GradesForm> createState() => _GradesFormState();
}

class _GradesFormState extends State<GradesForm> {
  final _valueController = TextEditingController();
  final _noteController = TextEditingController();
  TeacherClassResponse? _selectedClass;
  TeacherClassStudentResponse? _selectedStudent;
  String _dateKey = '';

  @override
  void initState() {
    super.initState();
    _selectedClass = widget.selectedClass;
    final now = DateTime.now();
    _dateKey =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _valueController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_selectedClass == null) {
      Snackbars.showError('Select a class');
      return;
    }
    if (_selectedStudent == null) {
      Snackbars.showError('Select a student');
      return;
    }
    final value = double.tryParse(_valueController.text.trim());
    if (value == null || value < 0 || value > 100) {
      Snackbars.showError('Enter valid grade (0-100)');
      return;
    }
    if (_dateKey.isEmpty) {
      Snackbars.showError('Select date');
      return;
    }
    context.read<TeacherGradesCubit>().upsertGrade(
      UpsertGradeParams(
        studentUserId: _selectedStudent!.effectiveUserId,
        classId: _selectedClass!.id,
        dateKey: _dateKey,
        value: value,
        note: _noteController.text.trim().isEmpty
            ? null
            : _noteController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TeacherGradesCubit, TeacherGradesState>(
      listenWhen: (_, s) =>
          s is TeacherGradesSuccess || s is TeacherGradesError,
      listener: (context, state) {
        if (state is TeacherGradesSuccess) {
          Snackbars.showSuccess('Grade saved');
          if (context.mounted) Navigator.of(context).pop();
        }
      },
      child: BlocListener<TeacherClassesCubit, TeacherClassesState>(
        listenWhen: (_, s) => s is TeacherClassesSuccess,
        listener: (context, state) {
          if (state is TeacherClassesSuccess &&
              state.classes.isNotEmpty &&
              _selectedClass == null) {
            final first = state.classes.first;
            setState(() => _selectedClass = first);
            context.read<TeacherClassStudentsCubit>().load(first.id);
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
                    final effectiveClass =
                        _selectedClass ??
                        (classes.isNotEmpty ? classes.first : null);
                    return DropdownButtonFormField<TeacherClassResponse>(
                      value: effectiveClass,
                      decoration: InputDecoration(
                        labelText: 'Class',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      items: classes
                          .map(
                            (c) =>
                                DropdownMenuItem(value: c, child: Text(c.name)),
                          )
                          .toList(),
                      onChanged: (v) {
                        setState(() {
                          _selectedClass = v;
                          _selectedStudent = null;
                        });
                        if (v != null)
                          context.read<TeacherClassStudentsCubit>().load(v.id);
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              SizedBox(height: 16.h),
              BlocBuilder<TeacherClassStudentsCubit, TeacherClassStudentsState>(
                builder: (context, state) {
                  if (_selectedClass == null) return const SizedBox.shrink();
                  if (state is TeacherClassStudentsLoading) {
                    return const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  if (state is TeacherClassStudentsSuccess) {
                    final students = state.students;
                    if (students.isEmpty) {
                      return Text(
                        'No students in this class',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.black500,
                        ),
                      );
                    }
                    return DropdownButtonFormField<TeacherClassStudentResponse>(
                      value:
                          _selectedStudent ??
                          (students.isNotEmpty ? students.first : null),
                      decoration: InputDecoration(
                        labelText: 'Student',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      items: students
                          .map(
                            (s) =>
                                DropdownMenuItem(value: s, child: Text(s.name)),
                          )
                          .toList(),
                      onChanged: (v) => setState(() => _selectedStudent = v),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              SizedBox(height: 16.h),
              TextField(
                controller: _valueController,
                decoration: InputDecoration(
                  labelText: 'Grade (0-100)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
              ),
              SizedBox(height: 16.h),
              ListTile(
                title: Text(
                  _dateKey.isEmpty ? 'Select date' : 'Date: $_dateKey',
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  final d = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime.now(),
                  );
                  if (d != null) {
                    setState(
                      () => _dateKey =
                          '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}',
                    );
                  }
                },
              ),
              SizedBox(height: 16.h),
              TextField(
                controller: _noteController,
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: 'Note (optional)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
              SizedBox(height: 32.h),
              BlocBuilder<TeacherGradesCubit, TeacherGradesState>(
                buildWhen: (_, s) => s is TeacherGradesSubmitting,
                builder: (context, state) {
                  final loading = state is TeacherGradesSubmitting;
                  return ElevatedButton(
                    onPressed: loading ? null : _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.bgColor,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: loading
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Save Grade'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
