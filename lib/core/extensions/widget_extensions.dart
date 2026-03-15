import 'package:flutter/material.dart';

extension WidgetExtensions on Widget {
  MaterialPageRoute get route => MaterialPageRoute(builder: (_) => this);
}
