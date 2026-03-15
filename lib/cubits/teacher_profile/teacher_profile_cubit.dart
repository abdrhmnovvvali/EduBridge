import 'package:dio/dio.dart';
import 'package:eduroom/data/models/remote/response/profile/teacher_profile_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../core/controllers/session_controller.dart';
import '../../core/helpers/logger.dart';
import '../../core/network/global_failure.dart';
import '../../core/services/internet_checker_service.dart';
import '../../data/contracts/teacher_profile/teacher_profile_contract.dart';

part 'teacher_profile_state.dart';

class TeacherProfileCubit extends Cubit<TeacherProfileState> {
  TeacherProfileCubit(this._internetCheckerService, this._teacherProfileContract) : super(TeacherProfileInitial());
   final InternetCheckerService _internetCheckerService;
  final TeacherProfileContract _teacherProfileContract;

   void getTeacherProfile() async {
    if (!SessionController.isLoggedIn) {
      emit(TeacherProfileSuccess(data: TeacherProfileResponse.empty()));
      return;
    }

    try {
      emit(TeacherProfileLoading());
      final hasInternetConnection = await _internetCheckerService
          .hasInternetConnection();
      if (!hasInternetConnection) {
        emit(const TeacherProfileNetworkError(failure: GlobalFailure.network()));
        return;
      }

      final result = await _teacherProfileContract.getTeacherProfile();

      emit(TeacherProfileSuccess(data: result));
    } on DioException catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      final errorMessage =
          e.response?.data['error'] ?? const GlobalFailure.server().message;
      emit(TeacherProfileError(failure: GlobalFailure(errorMessage)));
    } catch (e, s) {
      log.error('$e');
      log.error('$s');
      await Sentry.captureException(e, stackTrace: s);
      emit(const TeacherProfileError(failure: GlobalFailure.server()));
    }
  }

  
}
