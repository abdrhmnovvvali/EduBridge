import 'package:eduroom/core/network/dio/auth_client.dart';
import 'package:eduroom/core/network/dio/dio_client.dart';
import 'package:eduroom/data/models/remote/response/profile/student_profile_response.dart';

import '../../../../core/constants/endpoints.dart';

class StudentProfileDataSource {
  Future<StudentProfileResponse> getStudentProfile() async {
    final dio = dioClient;
    const endpoint = Endpoints.studentProfile;
    final result = await dio.get(endpoint);
    return StudentProfileResponse.fromJson(result.data);
  }
}
