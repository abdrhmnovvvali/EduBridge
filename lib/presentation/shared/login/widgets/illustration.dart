import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Illustration extends StatelessWidget {
  const Illustration({required this.assetPath});
  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, c) {
        return SizedBox(
          height: c.maxHeight,
          child: FittedBox(
            fit: BoxFit.contain,
            child: SvgPicture.asset(assetPath),
          ),
        );
      },
    );
  }
}
