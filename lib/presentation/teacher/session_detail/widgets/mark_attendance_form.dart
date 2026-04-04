import 'package:eduroom/core/constants/app_colors.dart';
import 'package:eduroom/cubits/teacher_attendance/teacher_attendance_cubit.dart';
import 'package:eduroom/cubits/teacher_class_students/teacher_class_students_cubit.dart';
import 'package:eduroom/data/models/remote/request/teacher/mark_attendance_params.dart' show MarkAttendanceParams, AttendanceEntry;
import 'package:eduroom/data/models/remote/response/teacher/teacher_class_student_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class _AttendanceRow extends StatefulWidget {
  const _AttendanceRow({
    super.key,
    required this.student,
    required this.initialPresent,
    required this.onChanged,
  });

  final TeacherClassStudentResponse student;
  final bool initialPresent;
  final ValueChanged<bool> onChanged;

  @override
  State<_AttendanceRow> createState() => _AttendanceRowState();
}

class _AttendanceRowState extends State<_AttendanceRow> {
  late bool _present;

  @override
  void initState() {
    super.initState();
    _present = widget.initialPresent;
  }

  @override
  void didUpdateWidget(_AttendanceRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialPresent != widget.initialPresent) {
      _present = widget.initialPresent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.graySoft50,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.graySoft100),
      ),
      child: Row(
        children: [
          Expanded(child: Text(widget.student.name, style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500))),
          Text('Present', style: TextStyle(fontSize: 12.sp, color: AppColors.black500)),
          SizedBox(width: 8.w),
          Switch(
            value: _present,
            onChanged: (v) {
              setState(() => _present = v);
              widget.onChanged(v);
            },
            activeTrackColor: AppColors.bgColor,
          ),
        ],
      ),
    );
  }
}

class MarkAttendanceForm extends StatefulWidget {
  const MarkAttendanceForm({super.key, required this.sessionId});

  final int sessionId;

  @override
  State<MarkAttendanceForm> createState() => _MarkAttendanceFormState();
}

class _MarkAttendanceFormState extends State<MarkAttendanceForm> {
  final Map<int, bool> _attendance = {};

  void _submit(List<TeacherClassStudentResponse> students) {
    if (students.isEmpty) return;
    final entries = students.map((s) => AttendanceEntry(
      studentUserId: s.effectiveUserId,
      status: (_attendance[s.id] ?? true) ? 'present' : 'absent',
      note: '',
    )).toList();
    context.read<TeacherAttendanceCubit>().markAttendance(widget.sessionId, MarkAttendanceParams(sessionId: widget.sessionId, attendance: entries));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeacherClassStudentsCubit, TeacherClassStudentsState>(
      builder: (context, state) {
        if (state is TeacherClassStudentsLoading) {
          return const Padding(
            padding: EdgeInsets.all(24.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (state is TeacherClassStudentsError) {
          return Padding(
            padding: EdgeInsets.all(16.w),
            child: Text(state.failure.message ?? 'Failed to load students', style: TextStyle(fontSize: 14.sp, color: AppColors.red500)),
          );
        }
        if (state is TeacherClassStudentsSuccess) {
          final students = state.students;
          if (students.isEmpty) {
            return Padding(
              padding: EdgeInsets.all(16.w),
              child: Text('No students in this class', style: TextStyle(fontSize: 14.sp, color: AppColors.black500)),
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ...students.map((s) => _AttendanceRow(
                key: ValueKey(s.id),
                student: s,
                initialPresent: _attendance[s.id] ?? true,
                onChanged: (v) {
                  setState(() => _attendance[s.id] = v);
                },
              )),
              SizedBox(height: 20.h),
              BlocBuilder<TeacherAttendanceCubit, TeacherAttendanceState>(
                buildWhen: (_, s) => s is TeacherAttendanceSubmitting,
                builder: (context, state) {
                  final loading = state is TeacherAttendanceSubmitting;
                  return ElevatedButton(
                    onPressed: loading ? null : () => _submit(students),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.bgColor,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                    ),
                    child: loading ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('Mark Attendance'),
                  );
                },
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
