class Endpoints {
  Endpoints._();

  static const _baseUrl = 'http://192.168.0.169:3000';
  static const teacherLogin = '$_baseUrl/teacher/login';
  static const student = '$_baseUrl/student/login';
  static const studentProfile='$_baseUrl/student/me/profile';
  static const teacherProfile='$_baseUrl/teacher/me/profile';
  
}
