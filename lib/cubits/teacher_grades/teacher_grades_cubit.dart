import 'package:dio/dio.dart';
import 'package:eduroom/core/helpers/logger.dart';
import 'package:eduroom/data/contracts/teacher_data/teacher_data_contract.dart';
import 'package:eduroom/data/models/remote/request/teacher/upsert_grade_params.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../core/network/global_failure.dart';
import '../../core/services/internet_checker_service.dart';

part 'teacher_grades_state.dart';

class TeacherGradesCubit extends Cubit<TeacherGradesState> {
  TeacherGradesCubit(this._internetCheckerService, this._contract) : super(TeacherGradesInitial());

  final InternetCheckerService _internetCheckerService;
  final TeacherDataContract _contract;

  Future<void> upsertGrade(UpsertGradeParams params) async {
    try {
      emit(TeacherGradesSubmitting());
      final hasInternet = await _internetCheckerService.hasInternetConnection();
      if (!hasInternet) {
        emit(const TeacherGradesError(failure: GlobalFailure.network()));
        return;
      }
      await _contract.upsertGrade(params);
      emit( TeacherGradesSuccess());
    } on DioException catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      emit(TeacherGradesError(failure: GlobalFailure(e.response?.data['message'] ?? 'Error')));
    } catch (e, s) {
      log.error('$e $s');
      await Sentry.captureException(e, stackTrace: s);
      emit(const TeacherGradesError(failure: GlobalFailure.server()));
    }
  }
}
