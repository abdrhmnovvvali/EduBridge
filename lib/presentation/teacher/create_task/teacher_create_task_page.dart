import 'package:eduroom/core/constants/app_colors.dart';
import 'package:eduroom/data/models/remote/response/teacher/teacher_class_response.dart';
import 'package:eduroom/presentation/teacher/create_task/widgets/create_task_form.dart';
import 'package:flutter/material.dart';

class TeacherCreateTaskPage extends StatelessWidget {
  const TeacherCreateTaskPage({super.key, this.selectedClass});

  final TeacherClassResponse? selectedClass;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Create Task'),
        backgroundColor: AppColors.bgColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: CreateTaskForm(selectedClass: selectedClass),
    );
  }
}
