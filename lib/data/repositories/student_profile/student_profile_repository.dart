import 'package:eduroom/data/contracts/student_profile/student_profile_contract.dart';
import 'package:eduroom/data/data_source/remote/student_profile/student_profile_data_source.dart';
import 'package:eduroom/data/models/remote/response/profile/student_profile_response.dart';

class StudentProfileRepository implements StudentProfileContract {
  StudentProfileRepository(this._studentProfileDataSource);
  final StudentProfileDataSource _studentProfileDataSource;

  @override
  Future<StudentProfileResponse> getStudentProfile() {
    return _studentProfileDataSource.getStudentProfile();
  }
}
