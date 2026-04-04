import 'package:dio/dio.dart';
import 'package:eduroom/core/helpers/logger.dart';
import 'package:eduroom/data/contracts/student_data/student_data_contract.dart';
import 'package:eduroom/data/models/remote/response/student/task_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../core/network/global_failure.dart';
import '../../core/services/internet_checker_service.dart';

part 'student_tasks_state.dart';

class StudentTasksCubit extends Cubit<StudentTasksState> {
  StudentTasksCubit(this._internetCheckerService, this._contract) : super(StudentTasksInitial());

  final InternetCheckerService _internetCheckerService;
  final StudentDataContract _contract;

  Future<void> load() async {
    try {
      emit(StudentTasksLoading());
      final hasInternet = await _internetCheckerService.hasInternetConnection();
      if (!hasInternet) {
        emit(const StudentTasksError(failure: GlobalFailure.network()));
        return;
      }
      final list = await _contract.getTasks();
      emit(StudentTasksSuccess(list));
    } on DioException catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      emit(StudentTasksError(failure: GlobalFailure(e.response?.data['message'] ?? 'Error')));
    } catch (e, s) {
      log.error('$e $s');
      await Sentry.captureException(e, stackTrace: s);
      emit(const StudentTasksError(failure: GlobalFailure.server()));
    }
  }
}
