import 'package:eduroom/data/models/remote/response/profile/student_profile_response.dart';

abstract class StudentProfileContract {


  Future<StudentProfileResponse>getStudentProfile();
  
}