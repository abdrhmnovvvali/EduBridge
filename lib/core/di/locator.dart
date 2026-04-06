import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:eduroom/cubits/connectivity/connectivity_cubit.dart';
import 'package:eduroom/cubits/login/login_cubit.dart';
import 'package:eduroom/cubits/student_attendance/student_attendance_cubit.dart';
import 'package:eduroom/cubits/student_grades/student_grades_cubit.dart';
import 'package:eduroom/cubits/student_invoices/student_invoices_cubit.dart';
import 'package:eduroom/cubits/student_leaderboard/student_leaderboard_cubit.dart';
import 'package:eduroom/cubits/student_materials/student_materials_cubit.dart';
import 'package:eduroom/cubits/student_notifications/student_notifications_cubit.dart';
import 'package:eduroom/cubits/student_profile/student_profile_cubit.dart';
import 'package:eduroom/cubits/student_teacher_feedback/student_teacher_feedback_cubit.dart';
import 'package:eduroom/cubits/student_tasks/student_tasks_cubit.dart';
import 'package:eduroom/cubits/teacher_class_students/teacher_class_students_cubit.dart';
import 'package:eduroom/cubits/teacher_classes/teacher_classes_cubit.dart';
import 'package:eduroom/cubits/teacher_attendance/teacher_attendance_cubit.dart';
import 'package:eduroom/cubits/teacher_class_sessions/teacher_class_sessions_cubit.dart';
import 'package:eduroom/cubits/teacher_create_session/teacher_create_session_cubit.dart';
import 'package:eduroom/cubits/teacher_grades/teacher_grades_cubit.dart';
import 'package:eduroom/cubits/teacher_materials/teacher_materials_cubit.dart';
import 'package:eduroom/cubits/teacher_profile/teacher_profile_cubit.dart';
import 'package:eduroom/cubits/teacher_task_submissions/teacher_task_submissions_cubit.dart';
import 'package:eduroom/cubits/teacher_tasks/teacher_tasks_cubit.dart';
import 'package:eduroom/data/contracts/login/login_contract.dart';
import 'package:eduroom/data/contracts/student_data/student_data_contract.dart';
import 'package:eduroom/data/contracts/student_profile/student_profile_contract.dart';
import 'package:eduroom/data/contracts/teacher_data/teacher_data_contract.dart';
import 'package:eduroom/data/contracts/teacher_profile/teacher_profile_contract.dart';
import 'package:eduroom/data/data_source/remote/login/login_data_source.dart';
import 'package:eduroom/data/data_source/remote/student/student_data_source.dart';
import 'package:eduroom/data/data_source/remote/student_profile/student_profile_data_source.dart';
import 'package:eduroom/data/data_source/remote/teacher/teacher_data_source.dart';
import 'package:eduroom/data/data_source/remote/teacher_profile/teacher_profile_data_soruce.dart';
import 'package:eduroom/data/repositories/login/login_repositories.dart';
import 'package:eduroom/data/repositories/student_data/student_data_repository.dart';
import 'package:eduroom/data/repositories/student_profile/student_profile_repository.dart';
import 'package:eduroom/data/repositories/teacher_data/teacher_data_repository.dart';
import 'package:eduroom/data/repositories/teacher_profile/teacher_profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../cubits/splash/splash_cubit.dart';
import '../../data/models/remote/response/session_response/session_response.dart';
import '../base/hive/base_hive.dart';
import '../base/locator/base_locator.dart';
import '../constants/hive_keys.dart';
import '../services/internet_checker_service.dart';

final locator = BaseLocator.instance;

Future<void> setupLocator() async {
  //   // Hive Data Sources
  //   locator.registerLazySingleton(() => LanguageHiveDataSource());

  final sessionHiveDataSource = BaseHive.getInstance<SessionResponse>(
    box: await Hive.openBox<String>(HiveKeys.sessionBox),
    fromJson: (json) => SessionResponse.fromJson(json),
  );

  locator.registerSingleton(sessionHiveDataSource);
  locator.registerLazySingleton<RouteObserver<ModalRoute>>(
    () => RouteObserver<PageRoute>(),
  );

  //   final settingsHiveDataSource = BaseHive.getInstance<SettingsLocalModel>(
  //     box: await Hive.openBox<String>(HiveKeys.settingsBox),
  //     fromJson: (json) => SettingsLocalModel.fromJson(json),
  //   );

  //   locator.registerSingleton(settingsHiveDataSource);

  //   // Singleton for any class
  locator.registerLazySingleton(() => AwesomeDioInterceptor());

  locator.registerFactory(() => SplashCubit());
  locator.registerFactory(() => ConnectivityCubit(Connectivity()));
  locator.registerFactory(() => LoginCubit(locator(), locator()));
  locator.registerFactory(() => StudentProfileCubit(locator(), locator()));
  locator.registerFactory(() => TeacherProfileCubit(locator(), locator()));
  locator.registerFactory(() => StudentTasksCubit(locator(), locator()));
  locator.registerFactory(() => StudentMaterialsCubit(locator(), locator()));
  locator.registerFactory(
    () => StudentTeacherFeedbackCubit(locator(), locator(), locator()),
  );
  locator.registerFactory(() => StudentAttendanceCubit(locator(), locator()));
  locator.registerFactory(() => StudentGradesCubit(locator(), locator()));
  locator.registerFactory(() => StudentInvoicesCubit(locator(), locator()));
  locator.registerFactory(() => StudentNotificationsCubit(locator(), locator()));
  locator.registerFactory(() => StudentLeaderboardCubit(locator(), locator()));
  locator.registerFactory(() => TeacherClassesCubit(locator(), locator()));
  locator.registerFactory(() => TeacherClassStudentsCubit(locator(), locator()));
  locator.registerFactory(() => TeacherClassSessionsCubit(locator(), locator()));
  locator.registerFactory(() => TeacherTasksCubit(locator(), locator()));
  locator.registerFactory(() => TeacherTaskSubmissionsCubit(locator(), locator()));
  locator.registerFactory(() => TeacherMaterialsCubit(locator(), locator()));
  locator.registerFactory(() => TeacherGradesCubit(locator(), locator()));
  locator.registerFactory(() => TeacherCreateSessionCubit(locator(), locator()));
  locator.registerFactory(() => TeacherAttendanceCubit(locator(), locator()));

  // Contract and Repositories
  locator.registerLazySingleton<LoginContract>(
    () => LoginRepositories(locator()),
  );
  locator.registerLazySingleton<StudentProfileContract>(
    () => StudentProfileRepository(locator()),
  );
  locator.registerLazySingleton<StudentDataContract>(
    () => StudentDataRepository(locator()),
  );
  locator.registerLazySingleton<TeacherProfileContract>(
    () => TeacherProfileRepository(locator()),
  );
  locator.registerLazySingleton<TeacherDataContract>(
    () => TeacherDataRepository(locator()),
  );

  // Data Sources
  locator.registerLazySingleton(() => InternetCheckerService());
  locator.registerLazySingleton(() => LoginDataSource());
  locator.registerLazySingleton(() => StudentProfileDataSource());
  locator.registerLazySingleton(() => StudentDataSource());
  locator.registerLazySingleton(() => TeacherProfileDataSoruce());
  locator.registerLazySingleton(() => TeacherDataSource());
}
