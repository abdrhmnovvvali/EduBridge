import 'package:dio/dio.dart';
import 'package:eduroom/core/constants/endpoints.dart';
import 'package:eduroom/core/network/dio/dio_client.dart';
import 'package:eduroom/data/models/remote/response/student/attendance_list_response.dart';
import 'package:eduroom/data/models/remote/response/student/attendance_response.dart';
import 'package:eduroom/data/models/remote/response/student/grade_response.dart';
import 'package:eduroom/data/models/remote/response/student/invoices_list_response.dart';
import 'package:eduroom/data/models/remote/response/student/leaderboard_response.dart';
import 'package:eduroom/data/models/remote/response/materials_page_response.dart';
import 'package:eduroom/data/models/remote/response/student/notification_response.dart';
import 'package:eduroom/data/models/remote/response/student/student_task_submission_response.dart';
import 'package:eduroom/data/models/remote/response/student/student_task_submissions_page_response.dart';
import 'package:eduroom/data/models/remote/response/student/task_response.dart';
import 'package:eduroom/data/models/remote/response/student/teacher_feedback_page_response.dart';

class StudentDataSource {
  final _dio = dioClient;

  Future<List<TaskResponse>> getTasks() async {
    final result = await _dio.get(Endpoints.studentTasks);
    final list = result.data is List ? result.data as List : [];
    return list.map((e) => TaskResponse.fromJson(e as Map<String, dynamic>)).toList();
  }

  /// Backend JSON gözləyir: `{ "answer": "..." }`. FormData + default `Content-Type: application/json`
  /// səbəbindən validasiya uğursuz olur — mətn üçün `Map`, fayl üçün multipart + düzgün content-type.
  Future<void> submitTask(int taskId, {String? comment, String? filePath}) async {
    final trimmed = comment?.trim() ?? '';
    final hasFile = filePath != null && filePath.isNotEmpty;
    if (trimmed.isEmpty && !hasFile) {
      throw ArgumentError('answer or file required');
    }

    // Fayl yoxdursa: təmiz JSON (application/json — DioConfigs ilə uyğun).
    if (!hasFile) {
      await _dio.post(
        Endpoints.studentTaskSubmit(taskId),
        data: <String, dynamic>{'answer': trimmed},
      );
      return;
    }

    // Fayl var: multipart; default JSON header multipart boundary-ı pozur — əlavə Options lazımdır.
    final answerField = trimmed.isNotEmpty ? trimmed : '(File submission)';
    final formData = FormData.fromMap({
      'answer': answerField,
      'file': await MultipartFile.fromFile(filePath),
    });
    await _dio.post(
      Endpoints.studentTaskSubmit(taskId),
      data: formData,
      options: Options(
        headers: <String, dynamic>{
          // DioConfigs `application/json` multipart boundary-ı pozur; FormData üçün əvəz et.
          Headers.contentTypeHeader: Headers.multipartFormDataContentType,
        },
      ),
    );
  }

  Future<TeacherFeedbackPageResponse> getTeacherFeedback({
    int page = 1,
    int limit = 20,
    int? classId,
  }) async {
    final safeLimit = limit.clamp(1, 50);
    final result = await _dio.get(
      Endpoints.studentTeacherFeedback,
      queryParameters: {
        'page': page,
        'limit': safeLimit,
        if (classId != null) 'classId': classId,
      },
    );
    final data = result.data;
    if (data is Map<String, dynamic>) {
      return TeacherFeedbackPageResponse.fromJson(data);
    }
    return TeacherFeedbackPageResponse(
      data: [],
      total: 0,
      page: 1,
      limit: safeLimit,
      totalPages: 0,
    );
  }

  Future<StudentTaskSubmissionsPageResponse> getStudentTaskSubmissions({
    int page = 1,
    int limit = 20,
    int? classId,
  }) async {
    final safeLimit = limit.clamp(1, 50);
    final result = await _dio.get(
      Endpoints.studentTaskSubmissions,
      queryParameters: {
        'page': page,
        'limit': safeLimit,
        if (classId != null) 'classId': classId,
      },
    );
    final data = result.data;
    if (data is Map<String, dynamic>) {
      return StudentTaskSubmissionsPageResponse.fromJson(data);
    }
    if (data is List) {
      return StudentTaskSubmissionsPageResponse(
        data: data
            .map((e) => StudentTaskSubmissionResponse.fromJson(e as Map<String, dynamic>))
            .toList(),
        total: data.length,
        page: 1,
        limit: data.length,
        totalPages: 1,
      );
    }
    return StudentTaskSubmissionsPageResponse(data: [], total: 0, page: 1, limit: safeLimit, totalPages: 0);
  }

  Future<MaterialsPageResponse> getMaterials({int page = 1, int limit = 20, int? classId}) async {
    final safeLimit = limit.clamp(1, 50);
    final result = await _dio.get(
      Endpoints.studentMaterials,
      queryParameters: {
        'page': page,
        'limit': safeLimit,
        if (classId != null) 'classId': classId,
      },
    );
    return MaterialsPageResponse.fromResponseBody(result.data);
  }

  Future<AttendanceListResponse> getAttendance({int? month, int? year}) async {
    final result = await _dio.get(
      Endpoints.studentAttendance,
      queryParameters: {
        if (month != null) 'month': month,
        if (year != null) 'year': year,
      },
    );
    final data = result.data;
    if (data is Map<String, dynamic>) {
      return AttendanceListResponse.fromJson(data);
    }
    if (data is List) {
      final items = data.map((e) => AttendanceResponse.fromJson(e as Map<String, dynamic>)).toList();
      final absentCount = items.where((e) => e.status.toUpperCase() == 'ABSENT').length;
      return AttendanceListResponse(items: items, absentCount: absentCount);
    }
    return AttendanceListResponse(items: [], absentCount: 0);
  }

  Future<List<GradeResponse>> getGrades() async {
    final result = await _dio.get(Endpoints.studentGrades);
    final list = result.data is List ? result.data as List : [];
    return list.map((e) => GradeResponse.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<InvoicesListResponse> getInvoices() async {
    final result = await _dio.get(Endpoints.studentInvoices);
    return InvoicesListResponse.fromResponseBody(result.data);
  }

  Future<List<NotificationResponse>> getNotifications() async {
    final result = await _dio.get(Endpoints.studentNotifications);
    final list = result.data is List ? result.data as List : [];
    return list.map((e) => NotificationResponse.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<void> markNotificationRead(int id) async {
    await _dio.patch(Endpoints.studentNotificationRead(id));
  }

  Future<LeaderboardResponse> getLeaderboard({int? classId, String? monthKey}) async {
    final result = await _dio.get(
      Endpoints.studentLeaderboard,
      queryParameters: {
        'classId': ?classId,
        'monthKey': ?monthKey,
      },
    );
    return LeaderboardResponse.fromJson(result.data);
  }
}
