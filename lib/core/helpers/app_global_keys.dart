import 'package:flutter/material.dart';

class AppGlobalKeys {
  AppGlobalKeys._() {
    navigatorKey = GlobalKey<NavigatorState>();
    scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  }

  static AppGlobalKeys? _instance;

  GlobalKey<NavigatorState>? navigatorKey;
  GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;

  factory AppGlobalKeys() => _instance ??= AppGlobalKeys._();

  BuildContext get context => navigatorKey!.currentState!.context;

  ScaffoldMessengerState? get scaffoldMessengerState =>
      scaffoldMessengerKey?.currentState;

  NavigatorState? get navigatorState => navigatorKey?.currentState;
}
