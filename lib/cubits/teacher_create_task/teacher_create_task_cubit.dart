import 'package:dio/dio.dart';
import 'package:eduroom/core/helpers/logger.dart';
import 'package:eduroom/core/network/global_failure.dart';
import 'package:eduroom/core/services/internet_checker_service.dart';
import 'package:eduroom/data/contracts/teacher_data/teacher_data_contract.dart';
import 'package:eduroom/data/models/remote/request/teacher/create_task_params.dart';
import 'package:eduroom/data/models/remote/response/teacher/teacher_class_response.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

part 'teacher_create_task_state.dart';

class TeacherCreateTaskCubit extends Cubit<TeacherCreateTaskState> {
  TeacherCreateTaskCubit(
    this._internetCheckerService,
    this._contract, {
    TeacherClassResponse? initialClass,
  }) : super(TeacherCreateTaskState(selectedClass: initialClass));

  final InternetCheckerService _internetCheckerService;
  final TeacherDataContract _contract;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  static String? _apiMessage(dynamic data) {
    if (data is! Map) return null;
    final msg = data['message'];
    if (msg is String) return msg;
    if (msg is List) return msg.map((e) => e.toString()).join(', ');
    return null;
  }

  void ensureDefaultClass(List<TeacherClassResponse> classes) {
    if (state.selectedClass == null && classes.isNotEmpty) {
      emit(state.copyWith(selectedClass: classes.first));
    }
  }

  void setSelectedClass(TeacherClassResponse? value) {
    emit(state.copyWith(selectedClass: value, clearFailure: true));
  }

  void setDueDate(DateTime? value) {
    emit(state.copyWith(dueDate: value, clearFailure: true));
  }

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null || result.files.isEmpty) return;
    final f = result.files.single;
    final path = f.path;
    if (path == null || path.isEmpty) return;
    emit(state.copyWith(
      pickedFilePath: path,
      pickedFileName: f.name,
      clearFailure: true,
    ));
  }

  void clearPickedFile() {
    emit(state.copyWith(clearPickedFile: true, clearFailure: true));
  }

  Future<void> submit() async {
    final current = state;
    if (current.selectedClass == null) {
      emit(current.copyWith(failure: const GlobalFailure('Select a class')));
      return;
    }
    final title = titleController.text.trim();
    if (title.isEmpty) {
      emit(current.copyWith(failure: const GlobalFailure('Enter title')));
      return;
    }

    emit(current.copyWith(status: TeacherCreateTaskStatus.submitting, clearFailure: true));

    try {
      final hasInternet = await _internetCheckerService.hasInternetConnection();
      if (!hasInternet) {
        emit(state.copyWith(
          status: TeacherCreateTaskStatus.idle,
          failure: const GlobalFailure.network(),
        ));
        return;
      }

      final desc = descriptionController.text.trim();
      await _contract.createTask(CreateTaskParams(
        classId: current.selectedClass!.id,
        title: title,
        description: desc.isEmpty ? null : desc,
        dueAt: current.dueDate,
      ));

      final path = state.pickedFilePath;
      if (path != null && path.isNotEmpty) {
        try {
          await _contract.uploadMaterialFile(
            filePath: path,
            classId: current.selectedClass!.id,
            title: title,
          );
        } on DioException catch (e, s) {
          await Sentry.captureException(e, stackTrace: s);
          emit(state.copyWith(
            status: TeacherCreateTaskStatus.taskCreatedFileUploadFailed,
            failure: GlobalFailure(
              _apiMessage(e.response?.data) ?? 'File upload failed',
            ),
          ));
          return;
        }
      }

      emit(state.copyWith(status: TeacherCreateTaskStatus.success));
    } on DioException catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      emit(state.copyWith(
        status: TeacherCreateTaskStatus.idle,
        failure: GlobalFailure(_apiMessage(e.response?.data) ?? 'Error'),
      ));
    } catch (e, s) {
      log.error('$e $s');
      await Sentry.captureException(e, stackTrace: s);
      emit(state.copyWith(
        status: TeacherCreateTaskStatus.idle,
        failure: const GlobalFailure.server(),
      ));
    }
  }

  @override
  Future<void> close() {
    titleController.dispose();
    descriptionController.dispose();
    return super.close();
  }
}
