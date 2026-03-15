import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';


class CustomLogo extends StatelessWidget {
  const CustomLogo({
    super.key,
    this.height = 375,
    this.width = 385,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AppAssets.gringoLogo,
      height: height.h,
      width: width.w,
    );
  }
}
