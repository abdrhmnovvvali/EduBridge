import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import '../../extensions/int_extensions.dart';
import '../../helpers/configs.dart';
import 'dio_configs.dart';

class CustomClient {
  CustomClient._();

  static final BaseOptions baseOptions = BaseOptions(
    contentType: DioConfigs.contentType,
    responseType: ResponseType.json,
    connectTimeout: DioConfigs.timeout,
    receiveTimeout: DioConfigs.timeout,
    followRedirects: DioConfigs.followRedirects,
    validateStatus: (status) => (status.isSuccess || status.isNotFound),
    receiveDataWhenStatusError: DioConfigs.receiveDataWhenStatusError,
    headers: DioConfigs.headers,
  );

  static HttpClient main(client) {
    SecurityContext sc = SecurityContext(withTrustedRoots: false);
    // sc.setTrustedCertificatesBytes(certBytes.buffer.asUint8List());
    client = HttpClient(context: sc);
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    if (Configs.proxyEnabled) {
      client.findProxy = (uri) => 'PROXY ${DioConfigs.proxy}';
    }
    return client;
  }

  static Future<Dio> sslPinnedDio(Dio? dio) async {
    // ByteData bytes = await rootBundle.load(Assets.pemCert);
    (dio?.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        (client) => CustomClient.main(client);
    return dio!;
  }

  static Future<Response<dynamic>> errorCloneRequest(
      DioException err, Dio client) async {
    final opts = Options(
        method: err.requestOptions.method, headers: err.requestOptions.headers);
    final cloneReq = await client.request(err.requestOptions.path,
        options: opts,
        data: err.requestOptions.data,
        queryParameters: err.requestOptions.queryParameters);
    return cloneReq;
  }
}
