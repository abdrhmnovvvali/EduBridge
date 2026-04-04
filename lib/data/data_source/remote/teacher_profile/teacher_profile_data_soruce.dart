import 'package:dio/dio.dart';
import 'package:eduroom/core/network/dio/dio_client.dart';
import 'package:eduroom/data/models/remote/response/profile/teacher_profile_response.dart';

import '../../../../core/constants/endpoints.dart';

class TeacherProfileDataSoruce {
  Future<TeacherProfileResponse> getTeacherProfile() async {
    final dio = dioClient;
    const endpoint = Endpoints.teacherProfile;
    final result = await dio.get(endpoint);
    if (result.statusCode != null && result.statusCode! >= 400) {
      throw DioException(
        requestOptions: result.requestOptions,
        response: result,
        type: DioExceptionType.badResponse,
      );
    }
    final data = result.data;
    if (data is Map && data['statusCode'] != null && (data['statusCode'] as int) >= 400) {
      throw DioException(
        requestOptions: result.requestOptions,
        response: result,
        type: DioExceptionType.badResponse,
      );
    }
    return TeacherProfileResponse.fromJson(data as Map<String, dynamic>);
  }
}
