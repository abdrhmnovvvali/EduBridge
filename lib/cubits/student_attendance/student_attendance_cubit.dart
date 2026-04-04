import 'package:dio/dio.dart';
import 'package:eduroom/core/helpers/logger.dart';
import 'package:eduroom/data/contracts/student_data/student_data_contract.dart';
import 'package:eduroom/data/models/remote/response/student/attendance_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../core/network/global_failure.dart';
import '../../core/services/internet_checker_service.dart';

part 'student_attendance_state.dart';

class StudentAttendanceCubit extends Cubit<StudentAttendanceState> {
  StudentAttendanceCubit(this._internetCheckerService, this._contract) : super(StudentAttendanceInitial());

  final InternetCheckerService _internetCheckerService;
  final StudentDataContract _contract;

  Future<void> load({int? month, int? year}) async {
    try {
      emit(StudentAttendanceLoading());
      final hasInternet = await _internetCheckerService.hasInternetConnection();
      if (!hasInternet) {
        emit(const StudentAttendanceError(failure: GlobalFailure.network()));
        return;
      }
      final response = await _contract.getAttendance(month: month, year: year);
      emit(StudentAttendanceSuccess(response.items, absentCount: response.absentCount));
    } on DioException catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      final msg = e.response?.data['message'];
      final msgStr = msg is List ? msg.join(' ') : (msg?.toString() ?? 'Error');
      emit(StudentAttendanceError(failure: GlobalFailure(msgStr)));
    } catch (e, s) {
      log.error('$e $s');
      await Sentry.captureException(e, stackTrace: s);
      emit(const StudentAttendanceError(failure: GlobalFailure.server()));
    }
  }
}
