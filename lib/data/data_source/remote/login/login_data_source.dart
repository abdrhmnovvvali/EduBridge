import 'package:eduroom/core/constants/endpoints.dart';
import 'package:eduroom/core/network/dio/auth_client.dart';
import 'package:eduroom/data/models/remote/request/login_params.dart';
import 'package:eduroom/data/models/remote/response/session_response/session_response.dart';

class LoginDataSource {
    Future<SessionResponse> teacherLogin(LoginParams params) async {
    final dio = authClient;
    const endpoint = Endpoints.teacherLogin;
    final body = params.toJson();
    final result = await dio.post(endpoint, data: body);
    return SessionResponse.fromJson(result.data);
  }
     Future<SessionResponse> studentLogin(LoginParams params) async {
    final dio = authClient;
    const endpoint = Endpoints.studentLogin;
    final body = params.toJson();
    final result = await dio.post(endpoint, data: body);
    return SessionResponse.fromJson(result.data);
  }
}