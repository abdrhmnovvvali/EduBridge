import 'package:eduroom/data/models/remote/response/student/attendance_list_response.dart';
import 'package:eduroom/data/models/remote/response/student/grade_response.dart';
import 'package:eduroom/data/models/remote/response/student/invoice_response.dart';
import 'package:eduroom/data/models/remote/response/student/leaderboard_response.dart';
import 'package:eduroom/data/models/remote/response/materials_page_response.dart';
import 'package:eduroom/data/models/remote/response/student/notification_response.dart';
import 'package:eduroom/data/models/remote/response/student/task_response.dart';

abstract class StudentDataContract {
  Future<List<TaskResponse>> getTasks();
  Future<void> submitTask(int taskId, {String? comment, String? filePath});
  Future<MaterialsPageResponse> getMaterials({int page = 1, int limit = 20, int? classId});
  Future<AttendanceListResponse> getAttendance({int? month, int? year});
  Future<List<GradeResponse>> getGrades();
  Future<List<InvoiceResponse>> getInvoices();
  Future<List<NotificationResponse>> getNotifications();
  Future<void> markNotificationRead(int id);
  Future<LeaderboardResponse> getLeaderboard({int? classId, String? monthKey});
}
