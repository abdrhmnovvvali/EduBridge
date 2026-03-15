import 'package:flutter/material.dart';

extension ColorExtensions on Color {
  MaterialColor get toMaterialColor => MaterialColor(
        value,
        <int, Color>{
          50: withValues(alpha: .1),
          100: withValues(alpha: .2),
          200: withValues(alpha: .3),
          300: withValues(alpha: .4),
          400: withValues(alpha: .5),
          500: withValues(alpha: .6),
          600: withValues(alpha: .7),
          700: withValues(alpha: .8),
          800: withValues(alpha: .9),
          900: withValues(alpha: 1.0),
        },
      );

  ColorFilter get toColorFilter => ColorFilter.mode(this, BlendMode.srcIn);
}
