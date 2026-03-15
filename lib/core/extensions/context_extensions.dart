import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  EdgeInsets get keyboardPadding => MediaQuery.viewInsetsOf(this);
  double get topStatusBarHeight => MediaQuery.paddingOf(this).top;
  double get bottomStatusBarHeight => MediaQuery.paddingOf(this).bottom;
}
