import 'package:eduroom/core/constants/app_colors.dart';
import 'package:eduroom/core/helpers/snackbars/snackbars.dart';
import 'package:eduroom/cubits/teacher_classes/teacher_classes_cubit.dart';
import 'package:eduroom/cubits/teacher_materials/teacher_materials_cubit.dart';
import 'package:eduroom/data/models/remote/request/teacher/link_material_params.dart';
import 'package:eduroom/data/models/remote/response/teacher/teacher_class_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class LinkMaterialForm extends StatefulWidget {
  const LinkMaterialForm({super.key, this.selectedClass});

  final TeacherClassResponse? selectedClass;

  @override
  State<LinkMaterialForm> createState() => _LinkMaterialFormState();
}

class _LinkMaterialFormState extends State<LinkMaterialForm> {
  final _titleController = TextEditingController();
  final _urlController = TextEditingController();
  TeacherClassResponse? _selectedClass;

  @override
  void initState() {
    super.initState();
    _selectedClass = widget.selectedClass;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _urlController.dispose();
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
    if (_urlController.text.trim().isEmpty) {
      Snackbars.showError('Enter link URL');
      return;
    }
    context.read<TeacherMaterialsCubit>().linkMaterial(LinkMaterialParams(
          classId: _selectedClass!.id,
          title: _titleController.text.trim(),
          linkUrl: _urlController.text.trim(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TeacherMaterialsCubit, TeacherMaterialsState>(
      listenWhen: (_, s) => s is TeacherMaterialsSuccess || s is TeacherMaterialsError,
      listener: (context, state) {
        if (state is TeacherMaterialsSuccess) {
          Snackbars.showSuccess('Material linked');
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
              controller: _urlController,
              decoration: InputDecoration(
                labelText: 'Link URL',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
              ),
              keyboardType: TextInputType.url,
            ),
            SizedBox(height: 32.h),
            BlocBuilder<TeacherMaterialsCubit, TeacherMaterialsState>(
              buildWhen: (_, s) => s is TeacherMaterialsLinking,
              builder: (context, state) {
                final loading = state is TeacherMaterialsLinking;
                return ElevatedButton(
                  onPressed: loading ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.bgColor,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                  ),
                  child: loading ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('Link Material'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
