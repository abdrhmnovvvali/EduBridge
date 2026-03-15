import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../core/constants/app_assets.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_paddings.dart';
import '../../core/helpers/configs.dart';
import 'custom_button.dart';

class NoConnectivtyView extends StatelessWidget {
  const NoConnectivtyView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1.sh,
      width: 1.sw,
      child: ColoredBox(
        color: AppColors.white,
        child: Center(
          child: Padding(
            padding: AppPaddings.h24.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(AppAssets.noInternet, height: 200.r, width: 200.r),
                24.verticalSpace,
                DefaultTextStyle(
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.black900,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    height: 34.h / 20.sp,
                    overflow: TextOverflow.clip,
                    fontFamily: Configs.fontFamily,
                  ),
                  child: const Text('No Internet Connection'),
                ),
                48.verticalSpace,
                CustomButton(width: 1.sw, text: 'TRY AGAIN', onPressed: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
