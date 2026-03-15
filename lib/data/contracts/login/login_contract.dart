import 'package:eduroom/data/models/remote/request/login_params.dart';
import 'package:eduroom/data/models/remote/response/session_response/session_response.dart';

abstract class LoginContract {

Future<SessionResponse>teacherLogin( LoginParams params );
Future<SessionResponse>studentLogin( LoginParams params );
}