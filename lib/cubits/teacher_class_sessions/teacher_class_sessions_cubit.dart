import 'package:dio/dio.dart';
import 'package:eduroom/core/helpers/logger.dart';
import 'package:eduroom/data/contracts/teacher_data/teacher_data_contract.dart';
import 'package:eduroom/data/models/remote/response/teacher/teacher_session_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../core/network/global_failure.dart';
import '../../core/services/internet_checker_service.dart';

part 'teacher_class_sessions_state.dart';

class TeacherClassSessionsCubit extends Cubit<TeacherClassSessionsState> {
  TeacherClassSessionsCubit(this._internetCheckerService, this._contract) : super(TeacherClassSessionsInitial());

  final InternetCheckerService _internetCheckerService;
  final TeacherDataContract _contract;

  Future<void> load(int classId, {String? from, String? to}) async {
    try {
      emit(TeacherClassSessionsLoading());
      final hasInternet = await _internetCheckerService.hasInternetConnection();
      if (!hasInternet) {
        emit(const TeacherClassSessionsError(failure: GlobalFailure.network()));
        return;
      }
      final list = await _contract.getClassSessions(classId, from: from, to: to);
      emit(TeacherClassSessionsSuccess(list));
    } on DioException catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      emit(TeacherClassSessionsError(failure: GlobalFailure(e.response?.data['message'] ?? 'Error')));
    } catch (e, s) {
      log.error('$e $s');
      await Sentry.captureException(e, stackTrace: s);
      emit(const TeacherClassSessionsError(failure: GlobalFailure.server()));
    }
  }
}
