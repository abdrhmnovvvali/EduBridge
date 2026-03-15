// import 'package:flutter/material.dart';

// import '../../data/models/remote/response/session_response.dart';
// import '../base/hive/base_hive.dart';
// import '../di/locator.dart';
// import 'package:go_router/go_router.dart';
// import '../helpers/app_global_keys.dart';
// import '../../router/app_router.dart';
// import '../network/dio/dio_client.dart';

import 'package:flutter/material.dart';

import '../../data/models/remote/response/session_response/session_response.dart';
import '../base/hive/base_hive.dart';
import '../di/locator.dart';
import '../helpers/app_global_keys.dart';
import '../network/dio/dio_client.dart';

class SessionController {
  const SessionController._();

  static final _sessionHiveDataSource = locator<BaseHive<SessionResponse>>();

  static SessionResponse? get _sessionResponse =>
      _sessionHiveDataSource.getData();

  static String? get token => _sessionResponse?.accessToken;
  static String? get name => _sessionResponse?.user.fullName;
  static String? get phoneNumber => _sessionResponse?.user.phone;
  static String? get emailAddress => _sessionResponse?.user.email;
  static String? get role=> _sessionResponse?.user.role;
  static int? get id => _sessionResponse?.user.id;

  static bool get isLoggedIn => token != null;

  static Future<void> saveSessionResponse(SessionResponse response) =>
      _sessionHiveDataSource.saveData(response);

  static Future<void> logout({bool pleaseLoginAlert = false}) async {
    //reset singleten dio
    DioClient.instance.reset();
    await _sessionHiveDataSource.clearData();
    PaintingBinding.instance.imageCache.clear();
    PaintingBinding.instance.imageCache.clearLiveImages();

    // navigate to login page
    if (!AppGlobalKeys().context.mounted) return;
    // AppGlobalKeys().context.go(AppRoutes.login);

    // if (pleaseLoginAlert) Alerts.showLogoutInfo();
  }
}
