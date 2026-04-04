import 'package:dio/dio.dart';
import 'package:eduroom/core/helpers/logger.dart';
import 'package:eduroom/data/contracts/student_data/student_data_contract.dart';
import 'package:eduroom/data/models/remote/response/student/leaderboard_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../core/network/global_failure.dart';
import '../../core/services/internet_checker_service.dart';

part 'student_leaderboard_state.dart';

class StudentLeaderboardCubit extends Cubit<StudentLeaderboardState> {
  StudentLeaderboardCubit(this._internetCheckerService, this._contract) : super(StudentLeaderboardInitial());

  final InternetCheckerService _internetCheckerService;
  final StudentDataContract _contract;

  Future<void> load({int? classId, String? monthKey}) async {
    try {
      emit(StudentLeaderboardLoading());
      final hasInternet = await _internetCheckerService.hasInternetConnection();
      if (!hasInternet) {
        emit(const StudentLeaderboardError(failure: GlobalFailure.network()));
        return;
      }
      final result = await _contract.getLeaderboard(classId: classId, monthKey: monthKey);
      emit(StudentLeaderboardSuccess(result));
    } on DioException catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      emit(StudentLeaderboardError(failure: GlobalFailure(e.response?.data['message'] ?? 'Error')));
    } catch (e, s) {
      log.error('$e $s');
      await Sentry.captureException(e, stackTrace: s);
      emit(const StudentLeaderboardError(failure: GlobalFailure.server()));
    }
  }
}
