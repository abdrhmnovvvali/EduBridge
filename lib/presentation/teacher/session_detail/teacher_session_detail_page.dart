import 'package:eduroom/core/constants/app_colors.dart';
import 'package:eduroom/core/helpers/snackbars/snackbars.dart';
import 'package:eduroom/cubits/teacher_attendance/teacher_attendance_cubit.dart';
import 'package:eduroom/data/models/remote/response/teacher/teacher_session_response.dart';
import 'package:eduroom/presentation/teacher/session_detail/widgets/mark_attendance_form.dart';
import 'package:eduroom/presentation/teacher/session_detail/widgets/session_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TeacherSessionDetailPage extends StatelessWidget {
  const TeacherSessionDetailPage({super.key, required this.session});

  final TeacherSessionResponse session;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Session #${session.id}'),
        backgroundColor: AppColors.bgColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocListener<TeacherAttendanceCubit, TeacherAttendanceState>(
        listenWhen: (_, s) => s is TeacherAttendanceSuccess || s is TeacherAttendanceError,
        listener: (context, state) {
          if (state is TeacherAttendanceSuccess) {
            Snackbars.showSuccess('Attendance marked');
            if (context.mounted) Navigator.of(context).pop();
          }
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SessionInfoCard(session: session),
              SizedBox(height: 24.h),
              Text('Mark Attendance', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
              SizedBox(height: 12.h),
              MarkAttendanceForm(sessionId: session.id),
            ],
          ),
        ),
      ),
    );
  }
}
