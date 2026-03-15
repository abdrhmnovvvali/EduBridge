import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_durations.dart';
import '../../../core/constants/app_paddings.dart';
import '../../../core/helpers/app_global_keys.dart';

class Snackbars {
  Snackbars._();

  static bool _isSnackBarVisible = false;

  static void _show(
    String message, {
    required Color backgroundColor,
    Duration duration = AppDurations.s1,
  }) {
    if (_isSnackBarVisible) return;

    _isSnackBarVisible = true;

    final snackBar = SnackBar(
      margin: AppPaddings.a16,
      duration: duration,
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      content: Text(
        message,
        style: TextStyle(
          fontSize: 14.sp,
          color: AppColors.white,
          fontWeight: FontWeight.w500,
          height: 20.h / 14.sp,
        ),
      ),
    );

    AppGlobalKeys()
        .scaffoldMessengerState
        ?.showSnackBar(snackBar)
        .closed
        .then((_) => _isSnackBarVisible = false);
  }

  static void showError(
    String message, {
    Duration? duration,
  }) =>
      _show(
        message,
        backgroundColor: AppColors.red500,
        duration: duration ?? AppDurations.s1,
      );

  static void showSuccess(
    String message, {
    Duration? duration,
  }) =>
      _show(
        message,
        backgroundColor: AppColors.secondary500,
        duration: duration ?? AppDurations.s1,
      );

  static void showInfo(
    String message, {
    Duration? duration,
  }) =>
      _show(
        message,
        backgroundColor: AppColors.yellow,
        duration: duration ?? AppDurations.s1,
      );
}
