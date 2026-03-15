import 'package:eduroom/core/helpers/pager.dart';
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
