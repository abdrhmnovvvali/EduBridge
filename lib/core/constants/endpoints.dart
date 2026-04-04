class Endpoints {
  Endpoints._();

  static const _baseUrl = 'http://10.50.0.115:3000';

  // Auth
  static const teacherLogin = '$_baseUrl/teacher/login';
  static const studentLogin = '$_baseUrl/student/login';

  // Student
  static const studentProfile = '$_baseUrl/student/me/profile';
  static const studentTasks = '$_baseUrl/student/me/tasks';
  static String studentTaskSubmit(int id) => '$_baseUrl/student/me/tasks/$id/submit';
  static const studentTaskSubmissions = '$_baseUrl/student/me/tasks/submissions';
  static const studentMaterials = '$_baseUrl/student/me/materials';
  static const studentAttendance = '$_baseUrl/student/me/attendance';
  static const studentGrades = '$_baseUrl/student/me/grades';
  static const studentInvoices = '$_baseUrl/student/me/invoices';
  static const studentNotifications = '$_baseUrl/student/me/notifications';
  static String studentNotificationRead(int id) => '$_baseUrl/student/me/notifications/$id/read';
  static const studentLeaderboard = '$_baseUrl/student/me/leaderboard';

  // Teacher
  static const teacherProfile = '$_baseUrl/teacher/me/profile';
  static const teacherProfilePhoto = '$_baseUrl/teacher/profile/photo';
  static const teacherClasses = '$_baseUrl/teacher/classes';
  static const teacherMeClasses = '$_baseUrl/teacher/classes';
  static String teacherClassSessions(int id) => '$_baseUrl/teacher/classes/$id/sessions';
  static String teacherClassStudents(int id) => '$_baseUrl/teacher/classes/$id/students';
  static const teacherSessions = '$_baseUrl/teacher/sessions';
  static String teacherSessionAttendance(int id) => '$_baseUrl/teacher/sessions/$id/attendance';
  static const teacherGrades = '$_baseUrl/teacher/grades';
  static const teacherTasks = '$_baseUrl/teacher/tasks';
  static String teacherTaskSubmissions(int id) => '$_baseUrl/teacher/tasks/$id/submissions';
  static String teacherTaskFeedback(int id) => '$_baseUrl/teacher/tasks/submissions/$id/feedback';
  static const teacherMaterials = '$_baseUrl/teacher/materials';
  static const teacherMaterialsLink = '$_baseUrl/teacher/materials/link';
  static const teacherMaterialsFile = '$_baseUrl/teacher/materials/file';
}
