import 'package:eduroom/core/router/app_routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_colors.dart';
import 'package:go_router/go_router.dart';
import '../../../cubits/splash/splash_cubit.dart';
import '../../widgets/custom_logo.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: BlocListener<SplashCubit, SplashState>(
        listener: (_, state) {
          switch (state) {
            case SplashState.login:
              context.go(AppRoutes.login);
              break;
            case SplashState.teacher:
              context.go(AppRoutes.teacherHome);
              break;
            case SplashState.student:
              context.go(AppRoutes.studentHome);
              break;
            default:
              break;
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Text(
                "EduBridge",
                style: TextStyle(
                  color: AppColors.black25,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              CustomLogo(),
            ],
          ),
        ),
      ),
    );
  }
}
