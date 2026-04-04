import 'package:eduroom/core/constants/app_colors.dart';
import 'package:eduroom/data/models/remote/response/teacher/teacher_class_response.dart';
import 'package:eduroom/presentation/teacher/materials/widgets/link_material_form.dart';
import 'package:flutter/material.dart';

class TeacherLinkMaterialPage extends StatelessWidget {
  const TeacherLinkMaterialPage({super.key, this.selectedClass});

  final TeacherClassResponse? selectedClass;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Link material'),
        backgroundColor: AppColors.bgColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: LinkMaterialForm(selectedClass: selectedClass),
    );
  }
}
