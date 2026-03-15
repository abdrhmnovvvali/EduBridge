import 'package:dio/dio.dart';


class BaseInterceptor extends QueuedInterceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // options.headers['Accept-Language'] = SettingsController.language;
    handler.next(options);
  }
}
