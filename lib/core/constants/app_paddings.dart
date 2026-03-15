import 'package:flutter/material.dart';

class AppPaddings {
  const AppPaddings._();

  static const EdgeInsets zero = EdgeInsets.zero;

  // All
  static const EdgeInsets a1 = EdgeInsets.all(1);
  static const EdgeInsets a2 = EdgeInsets.all(2);
  static const EdgeInsets a4 = EdgeInsets.all(4);
  static const EdgeInsets a6 = EdgeInsets.all(6);
  static const EdgeInsets a8 = EdgeInsets.all(8);
  static const EdgeInsets a10 = EdgeInsets.all(10);
  static const EdgeInsets a12 = EdgeInsets.all(12);
  static const EdgeInsets a16 = EdgeInsets.all(16);
  static const EdgeInsets a18 = EdgeInsets.all(18);
  static const EdgeInsets a20 = EdgeInsets.all(20);
  static const EdgeInsets a24 = EdgeInsets.all(24);

  // Right
  static const EdgeInsets r4 = EdgeInsets.only(right: 4);
  static const EdgeInsets r6 = EdgeInsets.only(right: 6);
  static const EdgeInsets r8 = EdgeInsets.only(right: 8);
  static const EdgeInsets r10 = EdgeInsets.only(right: 10);
  static const EdgeInsets r16 = EdgeInsets.only(right: 16);
  static const EdgeInsets r24 = EdgeInsets.only(right: 24);

  // Left
  static const EdgeInsets l4 = EdgeInsets.only(left: 4);
  static const EdgeInsets l8 = EdgeInsets.only(left: 8);
  static const EdgeInsets l12 = EdgeInsets.only(left: 12);
  static const EdgeInsets l16 = EdgeInsets.only(left: 16);

  //top
  static const EdgeInsets t76 = EdgeInsets.only(top: 76);
  static const EdgeInsets t50 = EdgeInsets.only(top: 50);
  static const EdgeInsets t54 = EdgeInsets.only(top: 54);
  static const EdgeInsets t18 = EdgeInsets.only(top: 18);
  static const EdgeInsets t20 = EdgeInsets.only(top: 20);
  static const EdgeInsets t16 = EdgeInsets.only(top: 16);
  static const EdgeInsets t12 = EdgeInsets.only(top: 12);
  static const EdgeInsets t8 = EdgeInsets.only(top: 8);
  static const EdgeInsets t6 = EdgeInsets.only(top: 6);
  static const EdgeInsets t4 = EdgeInsets.only(top: 4);
  static const EdgeInsets t28 = EdgeInsets.only(top: 28);
  static const EdgeInsets t24 = EdgeInsets.only(top: 24);

  //bottom
  static const EdgeInsets b4 = EdgeInsets.only(bottom: 4);
  static const EdgeInsets b16 = EdgeInsets.only(bottom: 16);
  static const EdgeInsets b24 = EdgeInsets.only(bottom: 24);
  static const EdgeInsets b48 = EdgeInsets.only(bottom: 48);
  static const EdgeInsets b76 = EdgeInsets.only(bottom: 76);

  // Horizontal
  static const EdgeInsets h4 = EdgeInsets.symmetric(horizontal: 4);
  static const EdgeInsets h6 = EdgeInsets.symmetric(horizontal: 6);
  static const EdgeInsets h8 = EdgeInsets.symmetric(horizontal: 8);
  static const EdgeInsets h10 = EdgeInsets.symmetric(horizontal: 10);
  static const EdgeInsets h12 = EdgeInsets.symmetric(horizontal: 12);
  static const EdgeInsets h16 = EdgeInsets.symmetric(horizontal: 16);
  static const EdgeInsets h24 = EdgeInsets.symmetric(horizontal: 24);
  static const EdgeInsets h11 = EdgeInsets.symmetric(horizontal: 11);

  // Vertical
  static const EdgeInsets v2 = EdgeInsets.symmetric(vertical: 2);
  static const EdgeInsets v4 = EdgeInsets.symmetric(vertical: 4);
  static const EdgeInsets v12 = EdgeInsets.symmetric(vertical: 12);
  static const EdgeInsets v14 = EdgeInsets.symmetric(vertical: 14);
  static const EdgeInsets v16 = EdgeInsets.symmetric(vertical: 16);
  static const EdgeInsets v20 = EdgeInsets.symmetric(vertical: 20);
  static const EdgeInsets v24 = EdgeInsets.symmetric(vertical: 24);
  static const EdgeInsets v50 = EdgeInsets.symmetric(vertical: 50);

  //lef right
  static const EdgeInsets lrt10 = EdgeInsets.only(left: 10, right: 10, top: 10);
  static const EdgeInsets t80r8l16 = EdgeInsets.only(
    top: 80,
    right: 8,
    left: 16,
  );
  static const EdgeInsets t12lr30 = EdgeInsets.only(
    top: 12,
    right: 30,
    left: 30,
  );
  static const EdgeInsets t13r7l14 = EdgeInsets.only(
    top: 13,
    right: 7,
    left: 14,
  );

  static const EdgeInsets tlr16 = EdgeInsets.only(left: 16, right: 16, top: 16);
}
