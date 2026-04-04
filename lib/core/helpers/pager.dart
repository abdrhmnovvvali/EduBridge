import 'package:eduroom/core/di/locator.dart';
import 'package:eduroom/cubits/login/login_cubit.dart';
import 'package:eduroom/cubits/student_attendance/student_attendance_cubit.dart';
import 'package:eduroom/cubits/student_grades/student_grades_cubit.dart';
import 'package:eduroom/cubits/student_invoices/student_invoices_cubit.dart';
import 'package:eduroom/cubits/student_leaderboard/student_leaderboard_cubit.dart';
import 'package:eduroom/cubits/student_materials/student_materials_cubit.dart';
import 'package:eduroom/cubits/student_notifications/student_notifications_cubit.dart';
import 'package:eduroom/cubits/student_profile/student_profile_cubit.dart';
import 'package:eduroom/cubits/student_tasks/student_tasks_cubit.dart';
import 'package:eduroom/cubits/splash/splash_cubit.dart';
import 'package:eduroom/cubits/teacher_attendance/teacher_attendance_cubit.dart';
import 'package:eduroom/cubits/teacher_classes/teacher_classes_cubit.dart';
import 'package:eduroom/cubits/teacher_create_session/teacher_create_session_cubit.dart';
import 'package:eduroom/cubits/teacher_grades/teacher_grades_cubit.dart';
import 'package:eduroom/cubits/teacher_materials/teacher_materials_cubit.dart';
import 'package:eduroom/cubits/teacher_profile/teacher_profile_cubit.dart';
import 'package:eduroom/cubits/teacher_task_submissions/teacher_task_submissions_cubit.dart';
import 'package:eduroom/cubits/teacher_tasks/teacher_tasks_cubit.dart';
import 'package:eduroom/cubits/teacher_class_students/teacher_class_students_cubit.dart';
import 'package:eduroom/cubits/teacher_class_sessions/teacher_class_sessions_cubit.dart';
import 'package:eduroom/data/models/remote/response/student/task_response.dart';
import 'package:eduroom/data/models/remote/response/teacher/teacher_class_response.dart';
import 'package:eduroom/data/models/remote/response/teacher/teacher_session_response.dart';
import 'package:eduroom/presentation/shared/login/login_page.dart';
import 'package:eduroom/presentation/shared/splash/splash_page.dart';
import 'package:eduroom/presentation/student/attendance/student_attendance_page.dart';
import 'package:eduroom/presentation/student/grades/student_grades_page.dart';
import 'package:eduroom/presentation/student/home/student_home_page.dart';
import 'package:eduroom/presentation/student/invoices/student_invoices_page.dart';
import 'package:eduroom/presentation/student/leaderboard/student_leaderboard_page.dart';
import 'package:eduroom/presentation/student/materials/student_materials_page.dart';
import 'package:eduroom/presentation/student/notifications/student_notifications_page.dart';
import 'package:eduroom/presentation/student/tasks/student_tasks_page.dart';
import 'package:eduroom/presentation/teacher/class_detail/teacher_class_detail_page.dart';
import 'package:eduroom/presentation/teacher/classes/teacher_classes_page.dart';
import 'package:eduroom/presentation/teacher/create_session/teacher_create_session_page.dart';
import 'package:eduroom/presentation/teacher/create_task/teacher_create_task_page.dart';
import 'package:eduroom/presentation/teacher/grades/teacher_grades_page.dart';
import 'package:eduroom/presentation/teacher/home/teacher_home_page.dart';
import 'package:eduroom/presentation/teacher/materials/teacher_materials_page.dart';
import 'package:eduroom/presentation/teacher/session_detail/teacher_session_detail_page.dart';
import 'package:eduroom/presentation/teacher/task_detail/teacher_task_detail_page.dart';
import 'package:eduroom/presentation/teacher/tasks/teacher_tasks_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Pager {
  Pager._();

  static Widget get splash => BlocProvider<SplashCubit>(
        create: (_) => locator()..waitSplash(),
        child: const SplashPage(),
      );

  static Widget get login => BlocProvider<LoginCubit>(
        create: (_) => locator(),
        child: const LoginPage(),
      );

  static Widget get teacherHome => BlocProvider<TeacherProfileCubit>(
        create: (_) => locator()..getTeacherProfile(),
        child: const TeacherHomePage(),
      );

  static Widget get teacherClasses => BlocProvider<TeacherClassesCubit>(
        create: (_) => locator()..load(),
        child: const TeacherClassesPage(),
      );

  static Widget get teacherTasks => BlocProvider<TeacherTasksCubit>(
        create: (_) => locator()..load(),
        child: const TeacherTasksPage(),
      );

  static Widget teacherCreateTask(TeacherClassResponse? selectedClass) =>
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => locator<TeacherClassesCubit>()..load()),
          BlocProvider(create: (_) => locator<TeacherTasksCubit>()),
        ],
        child: TeacherCreateTaskPage(selectedClass: selectedClass),
      );

  static Widget teacherTaskDetail(TaskResponse task) =>
      BlocProvider<TeacherTaskSubmissionsCubit>(
        create: (_) => locator<TeacherTaskSubmissionsCubit>()..load(task.id),
        child: TeacherTaskDetailPage(task: task),
      );

  static Widget teacherMaterials(TeacherClassResponse? selectedClass) =>
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => locator<TeacherClassesCubit>()..load()),
          BlocProvider(create: (_) => locator<TeacherMaterialsCubit>()),
        ],
        child: TeacherMaterialsPage(selectedClass: selectedClass),
      );

  static Widget teacherGrades(TeacherClassResponse? selectedClass) =>
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => locator<TeacherClassesCubit>()..load()),
          BlocProvider(create: (_) => locator<TeacherClassStudentsCubit>()),
          BlocProvider(create: (_) => locator<TeacherGradesCubit>()),
        ],
        child: TeacherGradesPage(selectedClass: selectedClass),
      );

  static Widget teacherClassDetail(TeacherClassResponse clazz) =>
      BlocProvider<TeacherClassSessionsCubit>(
        create: (_) => locator<TeacherClassSessionsCubit>()..load(clazz.id),
        child: TeacherClassDetailPage(clazz: clazz),
      );

  static Widget teacherCreateSession(TeacherClassResponse clazz) =>
      BlocProvider<TeacherCreateSessionCubit>(
        create: (_) => locator<TeacherCreateSessionCubit>(),
        child: TeacherCreateSessionPage(clazz: clazz),
      );

  static Widget teacherSessionDetail(TeacherSessionResponse session) =>
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => locator<TeacherClassStudentsCubit>()..load(session.classId)),
          BlocProvider(create: (_) => locator<TeacherAttendanceCubit>()),
        ],
        child: TeacherSessionDetailPage(session: session),
      );

  static Widget get studentHome => BlocProvider<StudentProfileCubit>(
        create: (_) => locator()..getStudentProfile(),
        child: const StudentHomePage(),
      );

  static Widget get studentTasks => BlocProvider<StudentTasksCubit>(
        create: (_) => locator()..load(),
        child: const StudentTasksPage(),
      );

  static Widget get studentMaterials => BlocProvider<StudentMaterialsCubit>(
        create: (_) => locator()..load(),
        child: const StudentMaterialsPage(),
      );

  static Widget get studentAttendance => BlocProvider<StudentAttendanceCubit>(
        create: (_) {
          final now = DateTime.now();
          return locator<StudentAttendanceCubit>()..load(month: now.month, year: now.year);
        },
        child: const StudentAttendancePage(),
      );

  static Widget get studentGrades => BlocProvider<StudentGradesCubit>(
        create: (_) => locator()..load(),
        child: const StudentGradesPage(),
      );

  static Widget get studentInvoices => BlocProvider<StudentInvoicesCubit>(
        create: (_) => locator()..load(),
        child: const StudentInvoicesPage(),
      );

  static Widget get studentNotifications =>
      BlocProvider<StudentNotificationsCubit>(
        create: (_) => locator()..load(),
        child: const StudentNotificationsPage(),
      );

  static Widget get studentLeaderboard => BlocProvider<StudentLeaderboardCubit>(
        create: (_) => locator()..load(),
        child: const StudentLeaderboardPage(),
      );
}
