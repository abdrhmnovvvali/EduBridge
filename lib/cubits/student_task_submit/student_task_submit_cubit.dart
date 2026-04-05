import 'package:dio/dio.dart';
import 'package:eduroom/core/helpers/logger.dart';
import 'package:eduroom/core/network/global_failure.dart';
import 'package:eduroom/core/services/internet_checker_service.dart';
import 'package:eduroom/data/contracts/student_data/student_data_contract.dart';
import 'package:eduroom/data/models/remote/response/student/task_response.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

part 'student_task_submit_state.dart';

class StudentTaskSubmitCubit extends Cubit<StudentTaskSubmitState> {
  StudentTaskSubmitCubit(
    this._internetCheckerService,
    this._contract, {
    required this.task,
  }) : super(const StudentTaskSubmitState());

  final InternetCheckerService _internetCheckerService;
  final StudentDataContract _contract;
  final TaskResponse task;

  final commentController = TextEditingController();

  static const _extensions = <String>[
    'pdf', 'doc', 'docx', 'ppt', 'pptx', 'xls', 'xlsx', 'txt', 'rtf',
    'zip', 'rar', '7z',
    'jpg', 'jpeg', 'png', 'gif', 'webp',
    'mp4', 'mov',
  ];

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: _extensions,
      allowMultiple: false,
    );
    if (result == null || result.files.isEmpty) return;
    final picked = result.files.single;
    final path = picked.path;
    if (path == null || path.isEmpty) return;
    emit(state.copyWith(
      pickedFilePath: path,
      pickedFileName: picked.name,
      clearFailure: true,
    ));
  }

  void clearPickedFile() {
    emit(state.copyWith(clearPickedFile: true, clearFailure: true));
  }

  static String? _apiMessage(dynamic data) {
    if (data is! Map) return null;
    final msg = data['message'];
    if (msg is String) return msg;
    if (msg is List) return msg.map((e) => e.toString()).join(', ');
    return null;
  }

  Future<void> submit() async {
    final comment = commentController.text.trim();
    final path = state.pickedFilePath;
    if (comment.isEmpty && (path == null || path.isEmpty)) {
      emit(state.copyWith(
        failure: const GlobalFailure('Add a comment and/or attach a file'),
      ));
      return;
    }

    emit(state.copyWith(status: StudentTaskSubmitStatus.submitting, clearFailure: true));

    try {
      final hasInternet = await _internetCheckerService.hasInternetConnection();
      if (!hasInternet) {
        emit(state.copyWith(
          status: StudentTaskSubmitStatus.idle,
          failure: const GlobalFailure.network(),
        ));
        return;
      }

      await _contract.submitTask(
        task.id,
        comment: comment.isEmpty ? null : comment,
        filePath: path,
      );

      emit(state.copyWith(status: StudentTaskSubmitStatus.success));
    } on DioException catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      emit(state.copyWith(
        status: StudentTaskSubmitStatus.idle,
        failure: GlobalFailure(_apiMessage(e.response?.data) ?? 'Could not submit'),
      ));
    } catch (e, s) {
      log.error('$e $s');
      await Sentry.captureException(e, stackTrace: s);
      emit(state.copyWith(
        status: StudentTaskSubmitStatus.idle,
        failure: const GlobalFailure.server(),
      ));
    }
  }

  @override
  Future<void> close() {
    commentController.dispose();
    return super.close();
  }
}
