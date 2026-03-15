import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';

import '../../controllers/session_controller.dart';
import '../../di/locator.dart';
import '../../extensions/int_extensions.dart';
import '../../helpers/configs.dart';
import '../../helpers/logger.dart';
import 'base_interceptor.dart';
import 'custom_client.dart';

part 'token_interceptor.dart';

class DioClient {
  DioClient._();

  static final DioClient instance = DioClient._();

  Dio? _dio;

  Dio get dio => _dio ??= _initDio();

  Dio _initDio() {
    _dio ??= Dio(CustomClient.baseOptions);

    _dio?.interceptors.add(BaseInterceptor());
    _dio?.interceptors.add(_TokenInterceptor());
    if (Configs.enableLogging) {
      _dio?.interceptors.add(locator<AwesomeDioInterceptor>());
    }

    return _dio!;
    // return await CustomClient.sslPinnedDio(_dio);
  }

  void reset() => _dio = null;
}

Dio get dioClient => DioClient.instance.dio;
