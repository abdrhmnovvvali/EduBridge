import 'package:dio/dio.dart';
import 'package:eduroom/core/helpers/logger.dart';
import 'package:eduroom/data/contracts/teacher_data/teacher_data_contract.dart';
import 'package:eduroom/data/models/remote/request/teacher/link_material_params.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../core/network/global_failure.dart';
import '../../core/services/internet_checker_service.dart';

part 'teacher_materials_state.dart';

class TeacherMaterialsCubit extends Cubit<TeacherMaterialsState> {
  TeacherMaterialsCubit(this._internetCheckerService, this._contract) : super(TeacherMaterialsInitial());

  final InternetCheckerService _internetCheckerService;
  final TeacherDataContract _contract;

  static String? _apiMessage(dynamic data) {
    if (data is! Map) return null;
    final msg = data['message'];
    if (msg is String) return msg;
    if (msg is List) return msg.map((e) => e.toString()).join(', ');
    return null;
  }

  Future<void> linkMaterial(LinkMaterialParams params) async {
    try {
      emit(TeacherMaterialsLinking());
      final hasInternet = await _internetCheckerService.hasInternetConnection();
      if (!hasInternet) {
        emit(const TeacherMaterialsError(failure: GlobalFailure.network()));
        return;
      }
      await _contract.linkMaterial(params);
      emit(TeacherMaterialsSuccess());
    } on DioException catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      emit(TeacherMaterialsError(failure: GlobalFailure(_apiMessage(e.response?.data) ?? 'Error')));
    } catch (e, s) {
      log.error('$e $s');
      await Sentry.captureException(e, stackTrace: s);
      emit(const TeacherMaterialsError(failure: GlobalFailure.server()));
    }
  }

  Future<void> uploadMaterialFile({
    required String filePath,
    required int classId,
    required String title,
  }) async {
    try {
      emit(TeacherMaterialsLinking());
      final hasInternet = await _internetCheckerService.hasInternetConnection();
      if (!hasInternet) {
        emit(const TeacherMaterialsError(failure: GlobalFailure.network()));
        return;
      }
      await _contract.uploadMaterialFile(filePath: filePath, classId: classId, title: title);
      emit(TeacherMaterialsSuccess());
    } on DioException catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      emit(TeacherMaterialsError(failure: GlobalFailure(_apiMessage(e.response?.data) ?? 'Error')));
    } catch (e, s) {
      log.error('$e $s');
      await Sentry.captureException(e, stackTrace: s);
      emit(const TeacherMaterialsError(failure: GlobalFailure.server()));
    }
  }
}
