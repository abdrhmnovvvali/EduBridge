import 'package:eduroom/core/constants/endpoints.dart';
import 'package:eduroom/core/network/dio/dio_client.dart';
import 'package:eduroom/data/models/remote/request/teacher/create_session_params.dart';
import 'package:eduroom/data/models/remote/request/teacher/create_task_params.dart';
import 'package:eduroom/data/models/remote/request/teacher/link_material_params.dart';
import 'package:eduroom/data/models/remote/request/teacher/mark_attendance_params.dart';
import 'package:eduroom/data/models/remote/request/teacher/upsert_grade_params.dart';
import 'package:eduroom/data/models/remote/response/student/material_response.dart';
import 'package:eduroom/data/models/remote/response/student/task_response.dart';
import 'package:eduroom/data/models/remote/response/teacher/teacher_class_response.dart';
import 'package:eduroom/data/models/remote/response/teacher/teacher_class_student_response.dart';
import 'package:eduroom/data/models/remote/response/teacher/teacher_session_response.dart';
import 'package:eduroom/data/models/remote/response/teacher/teacher_task_submission_response.dart';

class TeacherDataSource {
  final _dio = dioClient;

  Future<List<TeacherClassResponse>> getClasses() async {
    final result = await _dio.get(Endpoints.teacherClasses);
    final list = result.data is List ? result.data as List : [];
    return list.map((e) => TeacherClassResponse.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<List<TeacherClassResponse>> getMeClasses() async {
    final result = await _dio.get(Endpoints.teacherMeClasses);
    final list = result.data is List ? result.data as List : [];
    return list.map((e) => TeacherClassResponse.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<List<TeacherClassStudentResponse>> getClassStudents(int classId) async {
    final result = await _dio.get(Endpoints.teacherClassStudents(classId));
    final list = result.data is List ? result.data as List : [];
    return list.map((e) => TeacherClassStudentResponse.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<List<TeacherSessionResponse>> getClassSessions(int classId, {String? from, String? to}) async {
    final result = await _dio.get(
      Endpoints.teacherClassSessions(classId),
      queryParameters: {
        if (from != null) 'from': from,
        if (to != null) 'to': to,
      },
    );
    final list = result.data is List ? result.data as List : [];
    return list.map((e) => TeacherSessionResponse.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<List<TaskResponse>> getTasks() async {
    final result = await _dio.get(Endpoints.teacherTasks);
    final list = result.data is List ? result.data as List : [];
    return list.map((e) => TaskResponse.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<TaskResponse> createTask(CreateTaskParams params) async {
    final result = await _dio.post(Endpoints.teacherTasks, data: params.toJson());
    return TaskResponse.fromJson(result.data as Map<String, dynamic>);
  }

  Future<List<TeacherTaskSubmissionResponse>> getTaskSubmissions(int taskId) async {
    final result = await _dio.get(Endpoints.teacherTaskSubmissions(taskId));
    final list = result.data is List ? result.data as List : [];
    return list.map((e) => TeacherTaskSubmissionResponse.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<void> submitTaskFeedback(int submissionId, String feedback) async {
    await _dio.post(Endpoints.teacherTaskFeedback(submissionId), data: {'feedback': feedback});
  }

  Future<MaterialResponse> linkMaterial(LinkMaterialParams params) async {
    final result = await _dio.post(Endpoints.teacherMaterialsLink, data: params.toJson());
    return MaterialResponse.fromJson(result.data as Map<String, dynamic>);
  }

  Future<void> upsertGrade(UpsertGradeParams params) async {
    await _dio.post(Endpoints.teacherGrades, data: params.toJson());
  }

  Future<TeacherSessionResponse> createSession(CreateSessionParams params) async {
    final result = await _dio.post(Endpoints.teacherSessions, data: params.toJson());
    return TeacherSessionResponse.fromJson(result.data as Map<String, dynamic>);
  }

  Future<void> markAttendance(int sessionId, MarkAttendanceParams params) async {
    await _dio.post(Endpoints.teacherSessionAttendance(sessionId), data: params.toJson());
  }
}
