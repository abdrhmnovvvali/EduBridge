import 'package:dio/dio.dart';
import 'package:eduroom/core/helpers/logger.dart';
import 'package:eduroom/data/contracts/student_profile/student_profile_contract.dart';
import 'package:eduroom/data/models/remote/response/profile/student_profile_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../core/controllers/session_controller.dart';
import '../../core/network/global_failure.dart';
import '../../core/services/internet_checker_service.dart';

part 'student_profile_state.dart';

class StudentProfileCubit extends Cubit<StudentProfileState> {
  StudentProfileCubit(this._internetCheckerService, this._studentProfileContract) : super(StudentProfileInitial());

  final InternetCheckerService _internetCheckerService;
  final StudentProfileContract _studentProfileContract;

   void getStudentProfile() async {
    if (!SessionController.isLoggedIn) {
      emit(StudentProfileSuccess(data: StudentProfileResponse.empty()));
      return;
    }

    try {
      emit(StudentProfileLoading());
      final hasInternetConnection = await _internetCheckerService
          .hasInternetConnection();
      if (!hasInternetConnection) {
        emit(const StudentProfileNetworkError(failure: GlobalFailure.network()));
        return;
      }

      final result = await _studentProfileContract.getStudentProfile();

      emit(StudentProfileSuccess(data: result));
    } on DioException catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      final errorMessage =
          e.response?.data['error'] ?? const GlobalFailure.server().message;
      emit(StudentProfileError(failure: GlobalFailure(errorMessage)));
    } catch (e, s) {
      log.error('$e');
      log.error('$s');
      await Sentry.captureException(e, stackTrace: s);
      emit(const StudentProfileError(failure: GlobalFailure.server()));
    }
  }

  

}
