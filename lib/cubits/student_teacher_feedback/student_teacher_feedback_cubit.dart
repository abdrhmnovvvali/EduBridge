import 'package:dio/dio.dart';
import 'package:eduroom/core/network/global_failure.dart';
import 'package:eduroom/core/services/internet_checker_service.dart';
import 'package:eduroom/data/contracts/student_data/student_data_contract.dart';
import 'package:eduroom/data/contracts/student_profile/student_profile_contract.dart';
import 'package:eduroom/data/models/remote/response/profile/student_profile_response.dart';
import 'package:eduroom/data/models/remote/response/student/student_teacher_feedback_item.dart';
import 'package:eduroom/data/models/remote/response/student/teacher_feedback_page_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

part 'student_teacher_feedback_state.dart';

class StudentTeacherFeedbackCubit extends Cubit<StudentTeacherFeedbackState> {
  StudentTeacherFeedbackCubit(
    this._studentDataContract,
    this._studentProfileContract,
    this._internetCheckerService,
  ) : super(const StudentTeacherFeedbackState());

  final StudentDataContract _studentDataContract;
  final StudentProfileContract _studentProfileContract;
  final InternetCheckerService _internetCheckerService;

  static const int _limit = 20;

  static String? _apiMessage(dynamic data) {
    if (data is! Map) return null;
    final msg = data['message'];
    if (msg is String) return msg;
    if (msg is List) return msg.map((e) => e.toString()).join(', ');
    return null;
  }

  Future<void> load() async {
    if (state.isLoading) return;
    emit(state.copyWith(isLoading: true, clearFailure: true));
    if (!await _internetCheckerService.hasInternetConnection()) {
      emit(state.copyWith(failure: const GlobalFailure.network(), isLoading: false));
      return;
    }
    try {
      if (state.enrollments.isEmpty) {
        try {
          final profile = await _studentProfileContract.getStudentProfile();
          emit(state.copyWith(enrollments: profile.enrollments));
        } catch (_) {}
      }
      final classId = state.selectedClassId;
      final TeacherFeedbackPageResponse res = await _studentDataContract.getTeacherFeedback(
        page: 1,
        limit: _limit,
        classId: classId,
      );
      emit(
        state.copyWith(
          items: res.data,
          page: res.page,
          totalPages: res.totalPages,
          total: res.total,
          isLoading: false,
          isLoadingMore: false,
        ),
      );
    } on DioException catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      emit(
        state.copyWith(
          isLoading: false,
          failure: GlobalFailure(_apiMessage(e.response?.data) ?? 'Error'),
        ),
      );
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      emit(state.copyWith(isLoading: false, failure: const GlobalFailure.server()));
    }
  }

  Future<void> loadMore() async {
    if (state.isLoading || state.isLoadingMore || !state.hasMore) return;
    if (!await _internetCheckerService.hasInternetConnection()) {
      emit(state.copyWith(failure: const GlobalFailure.network()));
      return;
    }
    emit(state.copyWith(isLoadingMore: true, clearFailure: true));
    try {
      final nextPage = state.page + 1;
      final TeacherFeedbackPageResponse res = await _studentDataContract.getTeacherFeedback(
        page: nextPage,
        limit: _limit,
        classId: state.selectedClassId,
      );
      emit(
        state.copyWith(
          items: [...state.items, ...res.data],
          page: res.page,
          totalPages: res.totalPages,
          total: res.total,
          isLoadingMore: false,
        ),
      );
    } on DioException catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      emit(
        state.copyWith(
          isLoadingMore: false,
          failure: GlobalFailure(_apiMessage(e.response?.data) ?? 'Error'),
        ),
      );
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      emit(state.copyWith(isLoadingMore: false, failure: const GlobalFailure.server()));
    }
  }

  Future<void> setClassFilter(int? classId) async {
    if (classId == state.selectedClassId) return;
    emit(
      state.copyWith(
        selectedClassId: classId,
        clearSelectedClass: classId == null,
        items: [],
        page: 1,
        totalPages: 1,
        total: 0,
      ),
    );
    await load();
  }
}
