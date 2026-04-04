import 'package:dio/dio.dart';
import 'package:eduroom/core/helpers/logger.dart';
import 'package:eduroom/data/contracts/teacher_data/teacher_data_contract.dart';
import 'package:eduroom/data/models/remote/response/teacher/teacher_class_student_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../core/network/global_failure.dart';
import '../../core/services/internet_checker_service.dart';

part 'teacher_class_students_state.dart';

class TeacherClassStudentsCubit extends Cubit<TeacherClassStudentsState> {
  TeacherClassStudentsCubit(this._internetCheckerService, this._contract) : super(TeacherClassStudentsInitial());

  final InternetCheckerService _internetCheckerService;
  final TeacherDataContract _contract;

  Future<void> load(int classId) async {
    try {
      emit(TeacherClassStudentsLoading());
      final hasInternet = await _internetCheckerService.hasInternetConnection();
      if (!hasInternet) {
        emit(const TeacherClassStudentsError(failure: GlobalFailure.network()));
        return;
      }
      final list = await _contract.getClassStudents(classId);
      emit(TeacherClassStudentsSuccess(list));
    } on DioException catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      emit(TeacherClassStudentsError(failure: GlobalFailure(e.response?.data['message'] ?? 'Error')));
    } catch (e, s) {
      log.error('$e $s');
      await Sentry.captureException(e, stackTrace: s);
      emit(const TeacherClassStudentsError(failure: GlobalFailure.server()));
    }
  }
}
