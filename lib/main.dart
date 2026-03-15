import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:media_kit/media_kit.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'presentation/app.dart';
import 'core/di/locator.dart';
import 'core/helpers/app_bloc_observer.dart';
import 'core/helpers/app_sentry.dart';
import 'core/helpers/configs.dart';
import 'core/helpers/logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  await ScreenUtil.ensureScreenSize();

  await Hive.initFlutter();
  await setupLocator();

  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ],
  );

  FlutterError.onError = (errorDetails) {
    final exception = errorDetails.exception;
    final stackTrace = errorDetails.stack;
    log.error('Error::: $exception');
    log.info('Stack::: $stackTrace');
    AppSentry.captureError(exception, stackTrace);
  };

  PlatformDispatcher.instance.onError = (exception, stackTrace) {
    log.error('Error::: $exception');
    log.info('Stack::: $stackTrace');
    AppSentry.captureError(exception, stackTrace);
    return true;
  };

  if (kReleaseMode) {
    await SentryFlutter.init(
      (options) {
        options.debug = kDebugMode;
        options.dsn = Configs.sentryDsnUrl;
        options.tracesSampleRate = 1.0;
        options.profilesSampleRate = 1.0;
        options.sendDefaultPii = true;
      },
      appRunner: () => runZonedGuarded(
        () => runApp(SentryWidget(child: const MyApp())),
        (error, stack) {
          log.error('Error::: $error');
          log.info('Stack::: $stack');
          AppSentry.captureError(error, stack);
        },
      ),
    );
  } else {
    runApp(const MyApp());
  }
}