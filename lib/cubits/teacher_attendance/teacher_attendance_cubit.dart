import 'package:dio/dio.dart';
import 'package:eduroom/core/helpers/logger.dart';
import 'package:eduroom/data/contracts/teacher_data/teacher_data_contract.dart';
import 'package:eduroom/data/models/remote/request/teacher/mark_attendance_params.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../core/network/global_failure.dart';
import '../../core/services/internet_checker_service.dart';

part 'teacher_attendance_state.dart';

class TeacherAttendanceCubit extends Cubit<TeacherAttendanceState> {
  TeacherAttendanceCubit(this._internetCheckerService, this._contract) : super(TeacherAttendanceInitial());

  final InternetCheckerService _internetCheckerService;
  final TeacherDataContract _contract;

  Future<void> markAttendance(int sessionId, MarkAttendanceParams params) async {
    try {
      emit(TeacherAttendanceSubmitting());
      final hasInternet = await _internetCheckerService.hasInternetConnection();
      if (!hasInternet) {
        emit(const TeacherAttendanceError(failure: GlobalFailure.network()));
        return;
      }
      await _contract.markAttendance(sessionId, params);
      emit( TeacherAttendanceSuccess());
    } on DioException catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      final msg = e.response?.data['message'];
      final msgStr = msg is List ? msg.join(' ') : (msg?.toString() ?? 'Error');
      emit(TeacherAttendanceError(failure: GlobalFailure(msgStr)));
    } catch (e, s) {
      log.error('$e $s');
      await Sentry.captureException(e, stackTrace: s);
      emit(const TeacherAttendanceError(failure: GlobalFailure.server()));
    }
  }
}
