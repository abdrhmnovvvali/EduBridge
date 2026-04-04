import 'package:dio/dio.dart';
import 'package:eduroom/core/helpers/logger.dart';
import 'package:eduroom/data/contracts/teacher_data/teacher_data_contract.dart';
import 'package:eduroom/data/models/remote/request/teacher/create_task_params.dart';
import 'package:eduroom/data/models/remote/response/student/task_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../core/network/global_failure.dart';
import '../../core/services/internet_checker_service.dart';

part 'teacher_tasks_state.dart';

class TeacherTasksCubit extends Cubit<TeacherTasksState> {
  TeacherTasksCubit(this._internetCheckerService, this._contract) : super(TeacherTasksInitial());

  final InternetCheckerService _internetCheckerService;
  final TeacherDataContract _contract;

  Future<void> load() async {
    try {
      emit(TeacherTasksLoading());
      final hasInternet = await _internetCheckerService.hasInternetConnection();
      if (!hasInternet) {
        emit(const TeacherTasksError(failure: GlobalFailure.network()));
        return;
      }
      final list = await _contract.getTasks();
      emit(TeacherTasksSuccess(list));
    } on DioException catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      emit(TeacherTasksError(failure: GlobalFailure(e.response?.data['message'] ?? 'Error')));
    } catch (e, s) {
      log.error('$e $s');
      await Sentry.captureException(e, stackTrace: s);
      emit(const TeacherTasksError(failure: GlobalFailure.server()));
    }
  }

  Future<void> createTask(CreateTaskParams params) async {
    try {
      emit(TeacherTasksCreating());
      final hasInternet = await _internetCheckerService.hasInternetConnection();
      if (!hasInternet) {
        emit(const TeacherTasksError(failure: GlobalFailure.network()));
        return;
      }
      await _contract.createTask(params);
      await load();
    } on DioException catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      emit(TeacherTasksError(failure: GlobalFailure(e.response?.data['message'] ?? 'Error')));
    } catch (e, s) {
      log.error('$e $s');
      await Sentry.captureException(e, stackTrace: s);
      emit(const TeacherTasksError(failure: GlobalFailure.server()));
    }
  }
}
