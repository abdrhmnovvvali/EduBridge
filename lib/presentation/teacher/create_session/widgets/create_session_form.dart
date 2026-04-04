import 'package:eduroom/core/constants/app_colors.dart';
import 'package:eduroom/core/helpers/snackbars/snackbars.dart';
import 'package:eduroom/cubits/teacher_create_session/teacher_create_session_cubit.dart';
import 'package:eduroom/data/models/remote/request/teacher/create_session_params.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CreateSessionForm extends StatefulWidget {
  const CreateSessionForm({super.key, required this.classId});

  final int classId;

  @override
  State<CreateSessionForm> createState() => _CreateSessionFormState();
}

class _CreateSessionFormState extends State<CreateSessionForm> {
  DateTime _startsAt = DateTime.now();
  DateTime _endsAt = DateTime.now().add(const Duration(hours: 1));

  Future<void> _submit() async {
    context.read<TeacherCreateSessionCubit>().createSession(CreateSessionParams(
          classId: widget.classId,
          startsAt: _startsAt,
          endsAt: _endsAt,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TeacherCreateSessionCubit, TeacherCreateSessionState>(
      listenWhen: (_, s) => s is TeacherCreateSessionSuccess || s is TeacherCreateSessionError,
      listener: (context, state) {
        if (state is TeacherCreateSessionSuccess) {
          Snackbars.showSuccess('Session created');
          if (context.mounted) Navigator.of(context).pop();
        }
      },
      child: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListTile(
              title: Text('Start: ${_startsAt.toString().split('.')[0]}'),
              trailing: const Icon(Icons.access_time),
              onTap: () async {
                final t = await showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(_startsAt));
                if (t != null) {
                  final d = await showDatePicker(context: context, initialDate: _startsAt, firstDate: DateTime.now(), lastDate: DateTime.now().add(const Duration(days: 365)));
                  if (d != null) setState(() => _startsAt = DateTime(d.year, d.month, d.day, t.hour, t.minute));
                }
              },
            ),
            ListTile(
              title: Text('End: ${_endsAt.toString().split('.')[0]}'),
              trailing: const Icon(Icons.access_time),
              onTap: () async {
                final t = await showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(_endsAt));
                if (t != null) {
                  final d = await showDatePicker(context: context, initialDate: _endsAt, firstDate: DateTime.now(), lastDate: DateTime.now().add(const Duration(days: 365)));
                  if (d != null) setState(() => _endsAt = DateTime(d.year, d.month, d.day, t.hour, t.minute));
                }
              },
            ),
            SizedBox(height: 32.h),
            BlocBuilder<TeacherCreateSessionCubit, TeacherCreateSessionState>(
              buildWhen: (_, s) => s is TeacherCreateSessionCreating,
              builder: (context, state) {
                final loading = state is TeacherCreateSessionCreating;
                return ElevatedButton(
                  onPressed: loading ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.bgColor,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                  ),
                  child: loading ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('Create Session'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
