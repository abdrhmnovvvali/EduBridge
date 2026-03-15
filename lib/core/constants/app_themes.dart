import 'package:flutter/material.dart';

import '../helpers/configs.dart';
import 'app_colors.dart';

class AppThemes {
  AppThemes._();

  static ThemeData get appTheme => ThemeData(
        useMaterial3: true,
        // splashFactory: NoSplash.splashFactory,
        // highlightColor: AppColors.transparent,
        scaffoldBackgroundColor: AppColors.white,
        fontFamily: Configs.fontFamily,
        // colorScheme: ColorScheme.fromSwatch(
        //   primarySwatch: AppColors.primary.toMaterialColor,
        // ),
        // bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        //   selectedItemColor: AppColors.manatee,
        //   unselectedItemColor: AppColors.black,
        //   showSelectedLabels: false,
        //   showUnselectedLabels: false,
        //   type: BottomNavigationBarType.fixed,
        // ),
        // inputDecorationTheme: const InputDecorationTheme(
        //   border: AppBorders.inputBorder,
        //   errorBorder: AppBorders.inputBorder,
        //   enabledBorder: AppBorders.inputBorder,
        //   focusedBorder: AppBorders.focusedBorder,
        //   disabledBorder: AppBorders.inputBorder,
        //   focusedErrorBorder: AppBorders.inputBorder,
        // ),
        // checkboxTheme: const CheckboxThemeData(
        //   checkColor: WidgetStatePropertyAll(AppColors.white),
        //   shape: RoundedRectangleBorder(borderRadius: AppRadiuses.all4),
        // ),
        // radioTheme: const RadioThemeData(
        //   fillColor: WidgetStatePropertyAll(AppColors.primary),
        // ),
        // bottomSheetTheme: const BottomSheetThemeData(
        //   backgroundColor: AppColors.white,
        //   shape: RoundedRectangleBorder(borderRadius: AppRadiuses.all10),
        // ),
      );
}
