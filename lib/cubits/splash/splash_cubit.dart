import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants/app_durations.dart';
import '../../core/controllers/session_controller.dart';

enum SplashState { splash, onboard, language, login, teacher,student}

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashState.splash);

void waitSplash() async {
  await Future.delayed(AppDurations.s2);

  if (!SessionController.isLoggedIn) {
    emit(SplashState.login);
  } else {
    final role = SessionController.role;

    if (role == "TEACHER") {
      emit(SplashState.teacher);
    } else if (role == "STUDENT") {
      emit(SplashState.student);
    } else {
      emit(SplashState.login); 
    }
  }
}
}
