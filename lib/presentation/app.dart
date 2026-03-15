import 'package:eduroom/core/router/app_routers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../cubits/connectivity/connectivity_cubit.dart';
import '../core/constants/app_themes.dart';
import '../core/di/locator.dart';
import '../core/helpers/app_global_keys.dart';
import '../core/helpers/configs.dart';
import 'widgets/connectivity_aware.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
