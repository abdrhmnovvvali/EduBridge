import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../helpers/configs.dart';
import 'app_colors.dart';
import 'app_paddings.dart';
import 'app_radiuses.dart';

class AppButtonStyles {
  AppButtonStyles._();

  static final primary = ButtonStyle(
    foregroundColor: const WidgetStatePropertyAll(AppColors.white),
    backgroundColor: const WidgetStatePropertyAll(AppColors.primary500),
    overlayColor: const WidgetStatePropertyAll(AppColors.primary400),
    shadowColor: const WidgetStatePropertyAll(AppColors.transparent),
    // backgroundColor: WidgetStateProperty.resolveWith((states) {
    //   if (states.contains(WidgetState.pressed)) {
    //     return AppColors.primary400;
    //   }
    //   return AppColors.primary500;
    // }),
    fixedSize: WidgetStatePropertyAll(Size.fromHeight(48.h)),
    shape: const WidgetStatePropertyAll(
      RoundedRectangleBorder(borderRadius: AppRadiuses.a24),
    ),
    textStyle: WidgetStatePropertyAll(
      TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        fontFamily: Configs.fontFamily,
      ),
    ),
    elevation: const WidgetStatePropertyAll(0),
    padding: const WidgetStatePropertyAll(AppPaddings.zero),
    splashFactory: InkRipple.splashFactory,
  );

  static final disabled = primary.copyWith(
    backgroundColor: const WidgetStatePropertyAll(AppColors.black25),
    foregroundColor: const WidgetStatePropertyAll(AppColors.black100),
  );

  static final tertiaryTeal = primary.copyWith(
    backgroundColor: const WidgetStatePropertyAll(AppColors.tertiaryTeal500),
    overlayColor: const WidgetStatePropertyAll(Color(0xFF33754D)),
  );

  static final secondary = primary.copyWith(
    backgroundColor: const WidgetStatePropertyAll(AppColors.graySoft50),
    foregroundColor: const WidgetStatePropertyAll(AppColors.black900),
    overlayColor: const WidgetStatePropertyAll(AppColors.graySoft100),
    shape: const WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: AppRadiuses.a24,
        side: BorderSide(color: AppColors.graySoft100),
      ),
    ),
  );

  static final google = secondary;

  static final apple = primary.copyWith(
    backgroundColor: const WidgetStatePropertyAll(AppColors.black900),
    overlayColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.pressed)) {
        return AppColors.black500.withValues(alpha: 0.6);
      }
      return null;
    }),
  );
}
