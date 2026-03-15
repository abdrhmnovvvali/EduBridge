import 'package:eduroom/core/network/dio/auth_client.dart';
import 'package:eduroom/core/network/dio/dio_client.dart';
import 'package:eduroom/data/models/remote/response/profile/student_profile_response.dart';
import 'package:eduroom/data/models/remote/response/profile/teacher_profile_response.dart';

import '../../../../core/constants/endpoints.dart';

class TeacherProfileDataSoruce {
  Future<TeacherProfileResponse> getTeacherProfile() async {
    final dio = dioClient;
    const endpoint = Endpoints.teacherProfile;
    final result = await dio.get(endpoint);
    return TeacherProfileResponse.fromJson(result.data);
  }
}
