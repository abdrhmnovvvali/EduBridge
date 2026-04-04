import 'package:eduroom/core/constants/app_colors.dart';
import 'package:eduroom/data/models/remote/response/teacher/teacher_class_response.dart';
import 'package:eduroom/presentation/teacher/create_session/widgets/create_session_form.dart';
import 'package:flutter/material.dart';

class TeacherCreateSessionPage extends StatelessWidget {
  const TeacherCreateSessionPage({super.key, required this.clazz});

  final TeacherClassResponse clazz;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Create Session'),
        backgroundColor: AppColors.bgColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: CreateSessionForm(classId: clazz.id),
    );
  }
}
