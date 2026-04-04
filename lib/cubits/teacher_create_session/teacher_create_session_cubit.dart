import 'package:dio/dio.dart';
import 'package:eduroom/core/helpers/logger.dart';
import 'package:eduroom/data/contracts/teacher_data/teacher_data_contract.dart';
import 'package:eduroom/data/models/remote/request/teacher/create_session_params.dart';
import 'package:eduroom/data/models/remote/response/teacher/teacher_session_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../core/network/global_failure.dart';
import '../../core/services/internet_checker_service.dart';

part 'teacher_create_session_state.dart';

class TeacherCreateSessionCubit extends Cubit<TeacherCreateSessionState> {
  TeacherCreateSessionCubit(this._internetCheckerService, this._contract) : super(TeacherCreateSessionInitial());

  final InternetCheckerService _internetCheckerService;
  final TeacherDataContract _contract;

  Future<void> createSession(CreateSessionParams params) async {
    try {
      emit(TeacherCreateSessionCreating());
      final hasInternet = await _internetCheckerService.hasInternetConnection();
      if (!hasInternet) {
        emit(const TeacherCreateSessionError(failure: GlobalFailure.network()));
        return;
      }
      final session = await _contract.createSession(params);
      emit(TeacherCreateSessionSuccess(session));
    } on DioException catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      emit(TeacherCreateSessionError(failure: GlobalFailure(e.response?.data['message'] ?? 'Error')));
    } catch (e, s) {
      log.error('$e $s');
      await Sentry.captureException(e, stackTrace: s);
      emit(const TeacherCreateSessionError(failure: GlobalFailure.server()));
    }
  }
}
