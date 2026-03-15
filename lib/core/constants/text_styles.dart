import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../helpers/configs.dart';

class AppTextStyles {
  AppTextStyles._();

  static const headline1 = TextStyle(
    fontSize: 38,
    fontWeight: FontWeight.bold,
  );
  static const headline2 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.normal,
  );
  static const headline3 = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.normal,
  );
  static const headline4 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.normal,
  );
  static const headline5 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.normal,
  );
  static const headline6 = TextStyle(
    fontSize: 19,
    fontWeight: FontWeight.normal,
  );
  static const bodyText2 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.normal,
  );
  static const TextStyle bodyText1 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    fontFamily: Configs.fontFamily,
  );
  static const TextStyle subtitle1 = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.normal,
  );
  static const TextStyle subtitle2 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontFamily: Configs.fontFamily,
  );
  static final TextStyle subtitle3 = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.normal,
    fontFamily: Configs.fontFamily,
  );

  static const changeLanguageStyle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w500,
  );
  static const caption = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.normal,
    fontFamily: Configs.fontFamily,
  );

  static const overline = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.4,
  );
  static const button = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    fontFamily: Configs.fontFamily,
  );

  static TextTheme getDefaultTextTheme() => const TextTheme(
        displayLarge: AppTextStyles.headline1,
        displayMedium: AppTextStyles.headline2,
        displaySmall: AppTextStyles.headline3,
        headlineMedium: AppTextStyles.headline4,
        headlineSmall: AppTextStyles.headline5,
        titleLarge: AppTextStyles.headline6,
        bodyMedium: AppTextStyles.bodyText2,
        bodyLarge: AppTextStyles.bodyText1,
        titleMedium: AppTextStyles.subtitle1,
        titleSmall: AppTextStyles.subtitle2,
        bodySmall: AppTextStyles.caption,
        labelSmall: AppTextStyles.overline,
        labelLarge: AppTextStyles.button,
      );
}
