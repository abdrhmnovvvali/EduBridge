import 'package:eduroom/data/models/remote/request/teacher/create_session_params.dart';
import 'package:eduroom/data/models/remote/request/teacher/create_task_params.dart';
import 'package:eduroom/data/models/remote/request/teacher/link_material_params.dart';
import 'package:eduroom/data/models/remote/request/teacher/submit_task_feedback_params.dart';
import 'package:eduroom/data/models/remote/request/teacher/mark_attendance_params.dart';
import 'package:eduroom/data/models/remote/request/teacher/upsert_grade_params.dart';
import 'package:eduroom/data/models/remote/response/materials_page_response.dart';
import 'package:eduroom/data/models/remote/response/student/material_response.dart';
import 'package:eduroom/data/models/remote/response/student/task_response.dart';
import 'package:eduroom/data/models/remote/response/teacher/teacher_class_response.dart';
import 'package:eduroom/data/models/remote/response/teacher/teacher_class_student_response.dart';
import 'package:eduroom/data/models/remote/response/teacher/teacher_session_response.dart';
import 'package:eduroom/data/models/remote/response/teacher/teacher_task_submission_response.dart';

abstract class TeacherDataContract {
  Future<List<TeacherClassResponse>> getClasses();
  Future<List<TeacherClassResponse>> getMeClasses();
  Future<List<TeacherClassStudentResponse>> getClassStudents(int classId);
  Future<List<TeacherSessionResponse>> getClassSessions(int classId, {String? from, String? to});
  Future<List<TaskResponse>> getTasks();
  Future<TaskResponse> createTask(CreateTaskParams params);
  Future<List<TeacherTaskSubmissionResponse>> getTaskSubmissions(int taskId);
  Future<void> submitTaskFeedback(int submissionId, SubmitTaskFeedbackParams params);
  Future<MaterialsPageResponse> getMaterials({int page = 1, int limit = 20, int? classId});
  Future<MaterialResponse> linkMaterial(LinkMaterialParams params);
  Future<MaterialResponse?> uploadMaterialFile({
    required String filePath,
    required int classId,
    required String title,
  });
  Future<void> upsertGrade(UpsertGradeParams params);
  Future<TeacherSessionResponse> createSession(CreateSessionParams params);
  Future<void> markAttendance(int sessionId, MarkAttendanceParams params);
}
