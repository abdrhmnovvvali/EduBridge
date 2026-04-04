import 'package:dio/dio.dart';
import 'package:eduroom/core/helpers/logger.dart';
import 'package:eduroom/data/contracts/teacher_data/teacher_data_contract.dart';
import 'package:eduroom/data/models/remote/response/teacher/teacher_task_submission_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../core/network/global_failure.dart';
import '../../core/services/internet_checker_service.dart';

part 'teacher_task_submissions_state.dart';

class TeacherTaskSubmissionsCubit extends Cubit<TeacherTaskSubmissionsState> {
  TeacherTaskSubmissionsCubit(this._internetCheckerService, this._contract) : super(TeacherTaskSubmissionsInitial());

  final InternetCheckerService _internetCheckerService;
  final TeacherDataContract _contract;

  Future<void> load(int taskId) async {
    try {
      emit(TeacherTaskSubmissionsLoading());
      final hasInternet = await _internetCheckerService.hasInternetConnection();
      if (!hasInternet) {
        emit(const TeacherTaskSubmissionsError(failure: GlobalFailure.network()));
        return;
      }
      final list = await _contract.getTaskSubmissions(taskId);
      emit(TeacherTaskSubmissionsSuccess(list, taskId: taskId));
    } on DioException catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      emit(TeacherTaskSubmissionsError(failure: GlobalFailure(e.response?.data['message'] ?? 'Error')));
    } catch (e, s) {
      log.error('$e $s');
      await Sentry.captureException(e, stackTrace: s);
      emit(const TeacherTaskSubmissionsError(failure: GlobalFailure.server()));
    }
  }

  Future<void> submitFeedback(int submissionId, String feedback) async {
    try {
      final hasInternet = await _internetCheckerService.hasInternetConnection();
      if (!hasInternet) {
        emit(const TeacherTaskSubmissionsError(failure: GlobalFailure.network()));
        return;
      }
      await _contract.submitTaskFeedback(submissionId, feedback);
      final currentState = this.state;
      if (currentState is TeacherTaskSubmissionsSuccess) {
        load(currentState.taskId);
      }
    } on DioException catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      emit(TeacherTaskSubmissionsError(failure: GlobalFailure(e.response?.data['message'] ?? 'Error')));
    } catch (e, s) {
      log.error('$e $s');
      await Sentry.captureException(e, stackTrace: s);
      emit(const TeacherTaskSubmissionsError(failure: GlobalFailure.server()));
    }
  }
}
