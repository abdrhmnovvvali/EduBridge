import 'package:eduroom/core/router/app_routers.dart';
import 'package:eduroom/core/services/fcm_foreground_banner_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../cubits/connectivity/connectivity_cubit.dart';
import '../core/constants/app_themes.dart';
import '../core/di/locator.dart';
import '../core/helpers/app_global_keys.dart';
import '../core/helpers/configs.dart';
import 'widgets/connectivity_aware.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        if (Firebase.apps.isNotEmpty) {
          FcmForegroundBannerService.attachIfFirebaseReady();
        }
      } catch (_) {}
    });
  }

  @override
  void dispose() {
    FcmForegroundBannerService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider<ConnectivityCubit>(create: (_) => locator())],
      child: ScreenUtilInit(
        minTextAdapt: true,
        designSize: Configs.figmaDesignSize,
        builder: (context, _) => MaterialApp.router(
          builder: (_, child) => MediaQuery.withNoTextScaling(
            child: ConnectivityAware(whenConnected: child!),
          ),
          title: Configs.appName,
          theme: AppThemes.appTheme,
          debugShowCheckedModeBanner: false,
          routerConfig: appRouter,
          scaffoldMessengerKey: AppGlobalKeys().scaffoldMessengerKey,
        ),
      ),
    );
  }
}
