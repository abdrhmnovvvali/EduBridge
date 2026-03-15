import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';

import '../../di/locator.dart';
import '../../helpers/configs.dart';
import 'base_interceptor.dart';
import 'custom_client.dart';

class AuthClient {
  AuthClient._();

  static final instance = AuthClient._();

  Dio? _dio;

  Dio get dio => _dio ??= _initDio();

  Dio _initDio() {
    _dio ??= Dio(CustomClient.baseOptions);

    _dio?.interceptors.add(BaseInterceptor());
    if (Configs.enableLogging) {
      _dio?.interceptors.add(locator<AwesomeDioInterceptor>());
    }

    return _dio!;
    // return await CustomClient.sslPinnedDio(_dio);
  }
}

Dio get authClient => AuthClient.instance.dio;
