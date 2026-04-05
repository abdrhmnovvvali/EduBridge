import 'package:eduroom/data/contracts/student_data/student_data_contract.dart';
import 'package:eduroom/data/data_source/remote/student/student_data_source.dart';
import 'package:eduroom/data/models/remote/response/student/attendance_list_response.dart';
import 'package:eduroom/data/models/remote/response/student/grade_response.dart';
import 'package:eduroom/data/models/remote/response/student/invoice_response.dart';
import 'package:eduroom/data/models/remote/response/student/leaderboard_response.dart';
import 'package:eduroom/data/models/remote/response/student/material_response.dart';
import 'package:eduroom/data/models/remote/response/student/notification_response.dart';
import 'package:eduroom/data/models/remote/response/student/task_response.dart';

class StudentDataRepository implements StudentDataContract {
  StudentDataRepository(this._dataSource);

  final StudentDataSource _dataSource;

  @override
  Future<List<TaskResponse>> getTasks() => _dataSource.getTasks();

  @override
  Future<void> submitTask(int taskId, {String? comment, String? filePath}) =>
      _dataSource.submitTask(taskId, comment: comment, filePath: filePath);

  @override
  Future<List<MaterialResponse>> getMaterials() => _dataSource.getMaterials();

  @override
  Future<AttendanceListResponse> getAttendance({int? month, int? year}) =>
      _dataSource.getAttendance(month: month, year: year);

  @override
  Future<List<GradeResponse>> getGrades() => _dataSource.getGrades();

  @override
  Future<List<InvoiceResponse>> getInvoices() => _dataSource.getInvoices();

  @override
  Future<List<NotificationResponse>> getNotifications() => _dataSource.getNotifications();

  @override
  Future<void> markNotificationRead(int id) => _dataSource.markNotificationRead(id);

  @override
  Future<LeaderboardResponse> getLeaderboard({int? classId, String? monthKey}) =>
      _dataSource.getLeaderboard(classId: classId, monthKey: monthKey);
}
