import 'package:eduroom/core/di/locator.dart';
import 'package:eduroom/cubits/login/login_cubit.dart';
import 'package:eduroom/cubits/student_profile/student_profile_cubit.dart';
import 'package:eduroom/cubits/splash/splash_cubit.dart';
import 'package:eduroom/cubits/teacher_profile/teacher_profile_cubit.dart';
import 'package:eduroom/presentation/shared/login/login_page.dart';
import 'package:eduroom/presentation/shared/splash/splash_page.dart';
import 'package:eduroom/presentation/teacher/home/teacher_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/student/home/student_home_page.dart';

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
    create: (context) => locator()..getTeacherProfile(),
    child: TeacherHomePage(),
  );
  static Widget get studentHome => BlocProvider<StudentProfileCubit>(
    create: (_) => locator()..getStudentProfile(),
    child: StudentHomePage(),
  );
}
