import 'package:eduroom/data/contracts/login/login_contract.dart';
import 'package:eduroom/data/data_source/remote/login/login_data_source.dart';
import 'package:eduroom/data/models/remote/request/login_params.dart';
import 'package:eduroom/data/models/remote/response/session_response/session_response.dart';

class LoginRepositories implements LoginContract{
  LoginRepositories(this._loginDataSource);
  final LoginDataSource _loginDataSource;

  @override
  Future<SessionResponse> teacherLogin(LoginParams params) {
   return _loginDataSource.teacherLogin(params);
  }
  
  @override
  Future<SessionResponse> studentLogin(LoginParams params) {
    return _loginDataSource.studentLogin(params);
  }
}