import 'package:dio/dio.dart';
import 'package:eduroom/core/constants/endpoints.dart';
import 'package:eduroom/core/network/dio/dio_client.dart';
import 'package:eduroom/data/models/remote/response/student/attendance_list_response.dart';
import 'package:eduroom/data/models/remote/response/student/attendance_response.dart';
import 'package:eduroom/data/models/remote/response/student/grade_response.dart';
import 'package:eduroom/data/models/remote/response/student/invoice_response.dart';
import 'package:eduroom/data/models/remote/response/student/leaderboard_response.dart';
import 'package:eduroom/data/models/remote/response/materials_page_response.dart';
import 'package:eduroom/data/models/remote/response/student/notification_response.dart';
import 'package:eduroom/data/models/remote/response/student/task_response.dart';

class StudentDataSource {
  final _dio = dioClient;

  Future<List<TaskResponse>> getTasks() async {
    final result = await _dio.get(Endpoints.studentTasks);
    final list = result.data is List ? result.data as List : [];
    return list.map((e) => TaskResponse.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<void> submitTask(int taskId, {String? comment, String? filePath}) async {
    final map = <String, dynamic>{};
    if (comment != null && comment.isNotEmpty) {
      map['comment'] = comment;
    }
    if (filePath != null && filePath.isNotEmpty) {
      map['file'] = await MultipartFile.fromFile(filePath);
    }
    if (map.isEmpty) {
      throw ArgumentError('comment or file required');
    }
    await _dio.post(Endpoints.studentTaskSubmit(taskId), data: FormData.fromMap(map));
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

  Future<List<InvoiceResponse>> getInvoices() async {
    final result = await _dio.get(Endpoints.studentInvoices);
    final list = result.data is List ? result.data as List : [];
    return list.map((e) => InvoiceResponse.fromJson(e as Map<String, dynamic>)).toList();
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
