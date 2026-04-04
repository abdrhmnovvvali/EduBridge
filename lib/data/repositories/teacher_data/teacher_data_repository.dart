import 'package:eduroom/data/contracts/teacher_data/teacher_data_contract.dart';
import 'package:eduroom/data/data_source/remote/teacher/teacher_data_source.dart';
import 'package:eduroom/data/models/remote/request/teacher/create_session_params.dart';
import 'package:eduroom/data/models/remote/request/teacher/create_task_params.dart';
import 'package:eduroom/data/models/remote/request/teacher/link_material_params.dart';
import 'package:eduroom/data/models/remote/request/teacher/mark_attendance_params.dart';
import 'package:eduroom/data/models/remote/request/teacher/submit_task_feedback_params.dart';
import 'package:eduroom/data/models/remote/request/teacher/upsert_grade_params.dart';
import 'package:eduroom/data/models/remote/response/student/material_response.dart';
import 'package:eduroom/data/models/remote/response/student/task_response.dart';
import 'package:eduroom/data/models/remote/response/teacher/teacher_class_response.dart';
import 'package:eduroom/data/models/remote/response/teacher/teacher_class_student_response.dart';
import 'package:eduroom/data/models/remote/response/teacher/teacher_session_response.dart';
import 'package:eduroom/data/models/remote/response/teacher/teacher_task_submission_response.dart';

class TeacherDataRepository implements TeacherDataContract {
  TeacherDataRepository(this._dataSource);

  final TeacherDataSource _dataSource;

  @override
  Future<List<TeacherClassResponse>> getClasses() => _dataSource.getClasses();

  @override
  Future<List<TeacherClassResponse>> getMeClasses() => _dataSource.getMeClasses();

  @override
  Future<List<TeacherClassStudentResponse>> getClassStudents(int classId) =>
      _dataSource.getClassStudents(classId);

  @override
  Future<List<TeacherSessionResponse>> getClassSessions(int classId, {String? from, String? to}) =>
      _dataSource.getClassSessions(classId, from: from, to: to);

  @override
  Future<List<TaskResponse>> getTasks() => _dataSource.getTasks();

  @override
  Future<TaskResponse> createTask(CreateTaskParams params) => _dataSource.createTask(params);

  @override
  Future<List<TeacherTaskSubmissionResponse>> getTaskSubmissions(int taskId) =>
      _dataSource.getTaskSubmissions(taskId);

  @override
  Future<void> submitTaskFeedback(int submissionId, SubmitTaskFeedbackParams params) =>
      _dataSource.submitTaskFeedback(submissionId, params);

  @override
  Future<MaterialResponse> linkMaterial(LinkMaterialParams params) => _dataSource.linkMaterial(params);

  @override
  Future<void> upsertGrade(UpsertGradeParams params) => _dataSource.upsertGrade(params);

  @override
  Future<TeacherSessionResponse> createSession(CreateSessionParams params) =>
      _dataSource.createSession(params);

  @override
  Future<void> markAttendance(int sessionId, MarkAttendanceParams params) =>
      _dataSource.markAttendance(sessionId, params);
}
