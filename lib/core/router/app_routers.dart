import 'package:eduroom/core/helpers/pager.dart';
import 'package:eduroom/data/models/remote/response/profile/student_profile_response.dart';
import 'package:eduroom/data/models/remote/response/profile/teacher_profile_response.dart';
import 'package:eduroom/data/models/remote/response/student/task_response.dart';
import 'package:eduroom/data/models/remote/response/teacher/teacher_class_response.dart';
import 'package:eduroom/data/models/remote/response/teacher/teacher_session_response.dart';
import 'package:eduroom/presentation/student/profile/student_profile_page.dart';
import 'package:eduroom/presentation/teacher/profile/teacher_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../helpers/app_global_keys.dart';

class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String onboard = '/onboard';
  static const String language = '/language';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgetPassword = '/forgetPassword';
  static const String main = '/main';
  static const String teacherHome = '/teacherHome';
  static const String studentHome = '/studentHome';
  static const String studentTasks = '/studentTasks';
  static const String studentMaterials = '/studentMaterials';
  static const String studentAttendance = '/studentAttendance';
  static const String studentGrades = '/studentGrades';
  static const String studentInvoices = '/studentInvoices';
  static const String studentNotifications = '/studentNotifications';
  static const String studentLeaderboard = '/studentLeaderboard';
  static const String studentProfile = '/studentProfile';
  static const String studentTaskSubmit = '/studentTaskSubmit';

  static const String teacherClasses = '/teacherClasses';
  static const String teacherClassDetail = '/teacherClassDetail';
  static const String teacherProfile = '/teacherProfile';
  static const String teacherTasks = '/teacherTasks';
  static const String teacherCreateTask = '/teacherCreateTask';
  static const String teacherTaskDetail = '/teacherTaskDetail';
  static const String teacherMaterials = '/teacherMaterials';
  static const String teacherLinkMaterial = '/teacherLinkMaterial';
  static const String teacherGrades = '/teacherGrades';
  static const String teacherCreateSession = '/teacherCreateSession';
  static const String teacherSessionDetail = '/teacherSessionDetail';

  static const String tabFavorites = '/main/favorites';
  static const String tabSearch = '/main/search';
  static const String tabCompare = '/main/compare';
  static const String compareDetails = '/main/compare/details';
  static const String tabAccount = '/main/account';
  static const String alarmDeals = '/alarm-deals';
  static const String productDetails = '/product-details';
  static const String storeDetails = '/store-details';
  static const String genericPage = '/_page';
  static const String storyView = '/story-view';
  static const String partnyor = '/partnyor';
  static const String otp = 'otp';
  static const String phoneUpdateOtp = '/phone-update-otp';
}

final GoRouter appRouter = GoRouter(
  navigatorKey: AppGlobalKeys().navigatorKey,
  initialLocation: AppRoutes.splash,

  // Handle deep links by redirecting to splash/home
  routes: <RouteBase>[
    GoRoute(
      path: AppRoutes.genericPage,
      name: 'generic-page',
      pageBuilder: (context, state) {
        final widget = state.extra as Widget?;
        return MaterialPage(child: widget ?? const SizedBox.shrink());
      },
    ),

    GoRoute(
      path: AppRoutes.splash,
      name: 'splash',
      pageBuilder: (_, __) => MaterialPage(child: Pager.splash),
    ),

    GoRoute(
      path: AppRoutes.login,
      name: 'login',
      builder: (_, __) => Pager.login,
    ),

    GoRoute(
      path: AppRoutes.teacherHome,
      name: 'teacherHome',
      builder: (_, __) => Pager.teacherHome,
    ),
    GoRoute(
      path: AppRoutes.studentHome,
      name: 'studentHome',
      builder: (_, __) => Pager.studentHome,
    ),
    GoRoute(
      path: AppRoutes.studentTasks,
      name: 'studentTasks',
      builder: (_, __) => Pager.studentTasks,
    ),
    GoRoute(
      path: AppRoutes.studentTaskSubmit,
      name: 'studentTaskSubmit',
      builder: (context, state) {
        final task = state.extra as TaskResponse?;
        if (task == null) {
          return const Scaffold(body: Center(child: Text('Task not found')));
        }
        return Pager.studentTaskSubmit(task);
      },
    ),
    GoRoute(
      path: AppRoutes.studentMaterials,
      name: 'studentMaterials',
      builder: (_, __) => Pager.studentMaterials,
    ),
    GoRoute(
      path: AppRoutes.studentAttendance,
      name: 'studentAttendance',
      builder: (_, __) => Pager.studentAttendance,
    ),
    GoRoute(
      path: AppRoutes.studentGrades,
      name: 'studentGrades',
      builder: (_, __) => Pager.studentGrades,
    ),
    GoRoute(
      path: AppRoutes.studentInvoices,
      name: 'studentInvoices',
      builder: (_, __) => Pager.studentInvoices,
    ),
    GoRoute(
      path: AppRoutes.studentNotifications,
      name: 'studentNotifications',
      builder: (_, __) => Pager.studentNotifications,
    ),
    GoRoute(
      path: AppRoutes.studentLeaderboard,
      name: 'studentLeaderboard',
      builder: (_, __) => Pager.studentLeaderboard,
    ),
    GoRoute(
      path: AppRoutes.studentProfile,
      name: 'studentProfile',
      builder: (context, state) {
        final profile = state.extra as StudentProfileResponse?;
        if (profile == null) {
          return const Scaffold(
            body: Center(child: Text('Profile data not available')),
          );
        }
        return StudentProfilePage(profile: profile);
      },
    ),
    GoRoute(
      path: AppRoutes.teacherClasses,
      name: 'teacherClasses',
      builder: (_, __) => Pager.teacherClasses,
    ),
    GoRoute(
      path: AppRoutes.teacherClassDetail,
      name: 'teacherClassDetail',
      builder: (context, state) {
        final clazz = state.extra as TeacherClassResponse?;
        if (clazz == null) return const Scaffold(body: Center(child: Text('Class not found')));
        return Pager.teacherClassDetail(clazz);
      },
    ),
    GoRoute(
      path: AppRoutes.teacherProfile,
      name: 'teacherProfile',
      builder: (context, state) {
        final profile = state.extra as TeacherProfileResponse?;
        if (profile == null) {
          return const Scaffold(body: Center(child: Text('Profile data not available')));
        }
        return TeacherProfilePage(profile: profile);
      },
    ),
    GoRoute(
      path: AppRoutes.teacherTasks,
      name: 'teacherTasks',
      builder: (_, __) => Pager.teacherTasks,
    ),
    GoRoute(
      path: AppRoutes.teacherCreateTask,
      name: 'teacherCreateTask',
      builder: (context, state) {
        final clazz = state.extra as TeacherClassResponse?;
        return Pager.teacherCreateTask(clazz);
      },
    ),
    GoRoute(
      path: AppRoutes.teacherTaskDetail,
      name: 'teacherTaskDetail',
      builder: (context, state) {
        final task = state.extra as TaskResponse?;
        if (task == null) return const Scaffold(body: Center(child: Text('Task not found')));
        return Pager.teacherTaskDetail(task);
      },
    ),
    GoRoute(
      path: AppRoutes.teacherMaterials,
      name: 'teacherMaterials',
      builder: (context, state) {
        final clazz = state.extra as TeacherClassResponse?;
        return Pager.teacherMaterials(clazz);
      },
    ),
    GoRoute(
      path: AppRoutes.teacherLinkMaterial,
      name: 'teacherLinkMaterial',
      builder: (context, state) {
        final clazz = state.extra as TeacherClassResponse?;
        return Pager.teacherLinkMaterial(clazz);
      },
    ),
    GoRoute(
      path: AppRoutes.teacherGrades,
      name: 'teacherGrades',
      builder: (context, state) {
        final clazz = state.extra as TeacherClassResponse?;
        return Pager.teacherGrades(clazz);
      },
    ),
    GoRoute(
      path: AppRoutes.teacherCreateSession,
      name: 'teacherCreateSession',
      builder: (context, state) {
        final clazz = state.extra as TeacherClassResponse?;
        if (clazz == null) return const Scaffold(body: Center(child: Text('Class not found')));
        return Pager.teacherCreateSession(clazz);
      },
    ),
    GoRoute(
      path: AppRoutes.teacherSessionDetail,
      name: 'teacherSessionDetail',
      builder: (context, state) {
        final session = state.extra as TeacherSessionResponse?;
        if (session == null) return const Scaffold(body: Center(child: Text('Session not found')));
        return Pager.teacherSessionDetail(session);
      },
    ),

    // ShellRoute(
    //   builder: (context, state, child) => Pager.navShell(child),
    //   routes: [
    //     GoRoute(path: AppRoutes.main, redirect: (_, __) => AppRoutes.tabHome),

    //     GoRoute(
    //       path: AppRoutes.tabHome,
    //       pageBuilder: (_, __) => MaterialPage(child: Pager.home),
    //       routes: [
    //         GoRoute(
    //           path: 'page',
    //           name: 'home-generic-page',
    //           pageBuilder: (_, state) {
    //             final widget = state.extra as Widget?;
    //             return MaterialPage(child: widget ?? const SizedBox.shrink());
    //           },
    //         ),

    //       ],
    //     ),
    //   ],
    // ),
  ],
);
