import 'dart:async';

import 'package:eduroom/core/controllers/session_controller.dart';
import 'package:eduroom/core/services/fcm_foreground_banner_service.dart';
import 'package:eduroom/core/helpers/logger.dart';
import 'package:eduroom/data/contracts/student_data/student_data_contract.dart';
import 'package:eduroom/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

/// Şagird JWT aldıqdan sonra FCM token-ı `POST /student/me/push-token` ilə qeyd edir.
class StudentPushTokenService {
  StudentPushTokenService(this._studentData);

  final StudentDataContract _studentData;

  static bool _refreshListenerAttached = false;

  static bool _isStudentSession() {
    final r = SessionController.role;
    if (r == null) return false;
    return r.toUpperCase() == 'STUDENT';
  }

  /// `google-services.json` / `flutterfire configure` olmadan `false` qaytarır — tətbiq çökmür.
  Future<bool> _ensureFirebase() async {
    if (Firebase.apps.isNotEmpty) return true;
    try {
      await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
      return true;
    } catch (e, s) {
      if (e is UnsupportedError) {
        log.info('Firebase təyin deyil — FCM üçün `flutterfire configure` və google-services faylları lazımdır.');
      } else {
        log.error('Firebase init: $e\n$s');
      }
      return false;
    }
  }

  /// Login uğurlu olduqdan və sessiya saxlanıldıqdan sonra çağırın (yalnız şagird).
  Future<void> registerAfterLogin() async {
    if (!_isStudentSession()) return;
    try {
      if (!await _ensureFirebase()) return;
      FcmForegroundBannerService.attachIfFirebaseReady();
      final messaging = FirebaseMessaging.instance;
      await messaging.setAutoInitEnabled(true);
      await messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
      final token = await messaging.getToken();
      if (token == null || token.isEmpty) {
        log.info('FCM: token yoxdur');
        return;
      }
      log.info('FCM token: $token');
      await _studentData.registerStudentPushToken(token);
      _attachTokenRefreshIfNeeded();
    } catch (e, s) {
      log.error('FCM register: $e');
      log.error('$s');
    }
  }

  void _attachTokenRefreshIfNeeded() {
    if (_refreshListenerAttached) return;
    _refreshListenerAttached = true;
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
      unawaited(_onTokenRefresh(newToken));
    });
  }

  Future<void> _onTokenRefresh(String newToken) async {
    if (!SessionController.isLoggedIn || !_isStudentSession()) return;
    try {
      log.info('FCM token (yeniləndi): $newToken');
      await _studentData.registerStudentPushToken(newToken);
    } catch (e, s) {
      log.error('FCM token refresh sync: $e');
      log.error('$s');
    }
  }
}
