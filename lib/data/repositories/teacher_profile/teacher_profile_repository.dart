import 'package:eduroom/data/contracts/teacher_profile/teacher_profile_contract.dart';
import 'package:eduroom/data/models/remote/response/profile/teacher_profile_response.dart';

import '../../data_source/remote/teacher_profile/teacher_profile_data_soruce.dart';

class TeacherProfileRepository implements TeacherProfileContract {
  TeacherProfileRepository(this._teacherProfileDataSoruce);
  final TeacherProfileDataSoruce _teacherProfileDataSoruce;
  @override
  Future<TeacherProfileResponse> getTeacherProfile() {
    return _teacherProfileDataSoruce.getTeacherProfile();
  }
}
