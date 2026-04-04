import 'package:dio/dio.dart';
import 'package:eduroom/core/helpers/logger.dart';
import 'package:eduroom/data/contracts/teacher_data/teacher_data_contract.dart';
import 'package:eduroom/data/models/remote/response/teacher/teacher_class_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../core/network/global_failure.dart';
import '../../core/services/internet_checker_service.dart';

part 'teacher_classes_state.dart';

class TeacherClassesCubit extends Cubit<TeacherClassesState> {
  TeacherClassesCubit(this._internetCheckerService, this._contract) : super(TeacherClassesInitial());

  final InternetCheckerService _internetCheckerService;
  final TeacherDataContract _contract;

  Future<void> load() async {
    try {
      if (isClosed) return;
      emit(TeacherClassesLoading());
      final hasInternet = await _internetCheckerService.hasInternetConnection();
      if (!isClosed && !hasInternet) {
        emit(const TeacherClassesError(failure: GlobalFailure.network()));
        return;
      }
      if (isClosed) return;
      final list = await _contract.getMeClasses();
      if (!isClosed) emit(TeacherClassesSuccess(list));
    } on DioException catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      if (!isClosed) emit(TeacherClassesError(failure: GlobalFailure(e.response?.data['message'] ?? 'Error')));
    } catch (e, s) {
      log.error('$e $s');
      await Sentry.captureException(e, stackTrace: s);
      if (!isClosed) emit(const TeacherClassesError(failure: GlobalFailure.server()));
    }
  }
}
