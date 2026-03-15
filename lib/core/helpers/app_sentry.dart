import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class AppSentry {
  AppSentry._();

  static void captureError(dynamic exception, dynamic stackTrace) {
    if (kDebugMode) return;
    // Only capture errors in release mode
    Sentry.captureException(exception, stackTrace: stackTrace);
  }
}
