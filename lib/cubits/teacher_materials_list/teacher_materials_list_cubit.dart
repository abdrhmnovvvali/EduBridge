import 'package:dio/dio.dart';
import 'package:eduroom/core/helpers/logger.dart';
import 'package:eduroom/core/network/global_failure.dart';
import 'package:eduroom/core/services/internet_checker_service.dart';
import 'package:eduroom/data/contracts/teacher_data/teacher_data_contract.dart';
import 'package:eduroom/data/models/remote/response/materials_page_response.dart';
import 'package:eduroom/data/models/remote/response/student/material_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

part 'teacher_materials_list_state.dart';

class TeacherMaterialsListCubit extends Cubit<TeacherMaterialsListState> {
  TeacherMaterialsListCubit(
    this._internetCheckerService,
    this._contract, {
    int? classFilterId,
  })  : _classFilterId = classFilterId,
        super(TeacherMaterialsListInitial());

  final InternetCheckerService _internetCheckerService;
  final TeacherDataContract _contract;
  int? _classFilterId;

  static String? _apiMessage(dynamic data) {
    if (data is! Map) return null;
    final msg = data['message'];
    if (msg is String) return msg;
    if (msg is List) return msg.map((e) => e.toString()).join(', ');
    return null;
  }

  static List<MaterialResponse> _onlyFiles(MaterialsPageResponse r) =>
      r.data.where((m) => m.isFileType).toList();

  void setClassFilter(int? id) {
    _classFilterId = id;
    load();
  }

  Future<void> load({int page = 1}) async {
    try {
      emit(TeacherMaterialsListLoading());
      final hasInternet = await _internetCheckerService.hasInternetConnection();
      if (!hasInternet) {
        emit(const TeacherMaterialsListError(failure: GlobalFailure.network()));
        return;
      }
      final result = await _contract.getMaterials(page: page, limit: 20, classId: _classFilterId);
      emit(TeacherMaterialsListSuccess(
        materials: _onlyFiles(result),
        page: result.page,
        totalPages: result.totalPages,
        total: result.total,
      ));
    } on DioException catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      emit(TeacherMaterialsListError(failure: GlobalFailure(_apiMessage(e.response?.data) ?? 'Error')));
    } catch (e, s) {
      log.error('$e $s');
      await Sentry.captureException(e, stackTrace: s);
      emit(const TeacherMaterialsListError(failure: GlobalFailure.server()));
    }
  }
}
