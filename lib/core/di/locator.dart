import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:eduroom/cubits/connectivity/connectivity_cubit.dart';
import 'package:eduroom/cubits/login/login_cubit.dart';
import 'package:eduroom/cubits/student_profile/student_profile_cubit.dart';
import 'package:eduroom/cubits/teacher_profile/teacher_profile_cubit.dart';
import 'package:eduroom/data/contracts/login/login_contract.dart';
import 'package:eduroom/data/contracts/student_profile/student_profile_contract.dart';
import 'package:eduroom/data/contracts/teacher_profile/teacher_profile_contract.dart';
import 'package:eduroom/data/data_source/remote/login/login_data_source.dart';
import 'package:eduroom/data/data_source/remote/student_profile/student_profile_data_source.dart';
import 'package:eduroom/data/data_source/remote/teacher_profile/teacher_profile_data_soruce.dart';
import 'package:eduroom/data/repositories/login/login_repositories.dart';
import 'package:eduroom/data/repositories/student_profile/student_profile_repository.dart';
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

  //Contract and Repositories
  locator.registerLazySingleton<LoginContract>(
    () => LoginRepositories(locator()),
  );

  locator.registerLazySingleton<StudentProfileContract>(
    () => StudentProfileRepository(locator()),
  );
  locator.registerLazySingleton<TeacherProfileContract>(
    () => TeacherProfileRepository(locator()),
  );

  // Data Soruces
  locator.registerLazySingleton(() => InternetCheckerService());

  locator.registerLazySingleton(() => LoginDataSource());
  locator.registerLazySingleton(() => StudentProfileDataSource());
  locator.registerLazySingleton(() => TeacherProfileDataSoruce());
}
