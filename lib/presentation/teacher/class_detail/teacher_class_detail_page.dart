import 'package:eduroom/core/constants/app_colors.dart';
import 'package:eduroom/core/helpers/snackbars/snackbars.dart';
import 'package:eduroom/core/router/app_routers.dart';
import 'package:eduroom/cubits/teacher_class_sessions/teacher_class_sessions_cubit.dart';
import 'package:eduroom/data/models/remote/response/teacher/teacher_class_response.dart';
import 'package:eduroom/data/models/remote/response/teacher/teacher_session_response.dart';
import 'package:eduroom/presentation/teacher/class_detail/widgets/session_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class TeacherClassDetailPage extends StatelessWidget {
  const TeacherClassDetailPage({super.key, required this.clazz});

  final TeacherClassResponse clazz;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(clazz.name),
        backgroundColor: AppColors.bgColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await context.push(AppRoutes.teacherCreateSession, extra: clazz);
          if (context.mounted) {
            context.read<TeacherClassSessionsCubit>().load(clazz.id);
          }
        },
        backgroundColor: AppColors.bgColor,
        child: const Icon(Icons.add),
      ),
      body: BlocConsumer<TeacherClassSessionsCubit, TeacherClassSessionsState>(
        listener: (_, state) {
          if (state is TeacherClassSessionsError) {
            Snackbars.showError(state.failure.message ?? 'Error');
          }
        },
        builder: (context, state) {
          if (state is TeacherClassSessionsLoading || state is TeacherClassSessionsInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is TeacherClassSessionsSuccess) {
            final sessions = state.sessions;
            if (sessions.isEmpty) {
              return Center(
                child: Text('No sessions yet', style: TextStyle(fontSize: 16.sp, color: AppColors.black500)),
              );
            }
            return ListView.builder(
              padding: EdgeInsets.all(20.w),
              itemCount: sessions.length,
              itemBuilder: (_, i) => GestureDetector(
                onTap: () => context.push(AppRoutes.teacherSessionDetail, extra: sessions[i]),
                child: SessionCard(session: sessions[i]),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
