import '../../../../core/base/model/base_model.dart';

class LoginParams extends BaseModel {
  final String emailOrPhone;
  final String password;

  LoginParams({
    required this.emailOrPhone,
    required this.password,
  });

  @override 
  Map<String, dynamic> toJson() => {
        'email': emailOrPhone,
        'password': password,
      };

  @override
  List<Object?> get props => [emailOrPhone, password];
}
