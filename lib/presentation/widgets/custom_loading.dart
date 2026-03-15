import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({
    super.key,
    this.color = AppColors.white,
    this.size = 24,
  });

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size.r,
        width: size.r,
        child: Platform.isIOS
            ? CupertinoActivityIndicator(color: color, radius: size.r / 2)
            : CircularProgressIndicator(color: color),
      ),
    );
  }
}
