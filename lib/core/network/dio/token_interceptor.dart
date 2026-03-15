part of 'dio_client.dart';

class _TokenInterceptor extends QueuedInterceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (SessionController.isLoggedIn) {
      options.headers['Authorization'] = 'Bearer ${SessionController.token}';
    }
    handler.next(options);
  }

  @override
  void onError(
    DioException dioException,
    ErrorInterceptorHandler handler,
  ) async {
    final response = dioException.response;
    log.error('${response?.statusCode} : ${dioException.requestOptions.path}');
    if (response != null) {
      if (response.statusCode.isUnauthorized) {
        // await SessionController.logout(pleaseLoginAlert: true);
        return;
      }
    }
    handler.next(dioException);
  }
}
