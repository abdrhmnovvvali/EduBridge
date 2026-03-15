import 'package:flutter/material.dart';

class AppRadiuses {
  const AppRadiuses._();



  static const a10 = BorderRadius.all(Radius.circular(10));
  static const a12 = BorderRadius.all(Radius.circular(12));
  static const a16 = BorderRadius.all(Radius.circular(16));
  static const a24 = BorderRadius.all(Radius.circular(24));
  static const a40 = BorderRadius.all(Radius.circular(40));
  static const a8 = BorderRadius.all(Radius.circular(8));
  static const a4 = BorderRadius.all(Radius.circular(4));
  static const a2 = BorderRadius.all(Radius.circular(2));


  static const c25 = Radius.circular(25);
  static const c8 = Radius.circular(8);
  static const c4 = Radius.circular(4);

  static const infinity = BorderRadius.all(Radius.circular(99));
  static const tlr16 = BorderRadius.only(
    topLeft: Radius.circular(16),
    topRight: Radius.circular(16),
  );

  static const blr16 = BorderRadius.only(
    bottomLeft: Radius.circular(16), // Circular radius for the top-left
    bottomRight: Radius.circular(16), // Circular radius for the top-right
  );
}
