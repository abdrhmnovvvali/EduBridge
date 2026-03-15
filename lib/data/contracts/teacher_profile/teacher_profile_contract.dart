import 'package:eduroom/data/models/remote/response/profile/teacher_profile_response.dart';

abstract class TeacherProfileContract {


  Future<TeacherProfileResponse>getTeacherProfile();
}