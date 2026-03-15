import 'package:flutter/material.dart';

import '../../core/constants/app_button_styles.dart';
import 'custom_loading.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.text = '',
    this.onPressed,
    this.isLoading = false,
    this.disabled = false,
    this.style,
    this.disabledStyle,
    this.child,
    this.height,
    this.width,
    this.textStyle,
  });

  final double? width;
  final String? text;
  final void Function()? onPressed;
  final bool isLoading;
  final bool disabled;
  final ButtonStyle? style;
  final ButtonStyle? disabledStyle;
  final Widget? child;
  final double? height;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: disabled
            ? (disabledStyle ?? AppButtonStyles.disabled)
            : (style ?? AppButtonStyles.primary),
        onPressed: disabled ? null : onPressed,
        child: isLoading
            ? const CustomLoading()
            : (child ??
                Text(
                  text!,
                  style: textStyle,
                )),
      ),
    );
  }
}
