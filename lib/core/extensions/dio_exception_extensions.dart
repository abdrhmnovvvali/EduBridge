import 'dart:io';

import 'package:dio/dio.dart';

extension DioExceptionExtensions on DioException {
  bool get isNetworkError => error is SocketException;
}
