import 'dart:developer' as dev;

import '../enums/log_type.dart';
import 'configs.dart';

const log = Logger();

class Logger {
  const Logger();

  static const Map<LogType, String> _logTypes = {
    LogType.debug: 'DEBUG: 🐞',
    LogType.info: 'INFO: 📝',
    LogType.warning: 'WARNING: ℹ️',
    LogType.error: 'ERROR: ❌',
    LogType.success: 'SUCCESS: ✅',
  };

  String _getPrefix(LogType type) => _logTypes[type]!;

  void _log(String message, {required String prefix}) {
    if (Configs.enableLogging) dev.log(message, name: prefix);
  }

  void debug(String message) =>
      _log(message, prefix: _getPrefix(LogType.debug));

  void info(String message) => _log(message, prefix: _getPrefix(LogType.info));

  void warning(String message) =>
      _log(message, prefix: _getPrefix(LogType.warning));

  void error(String message) =>
      _log(message, prefix: _getPrefix(LogType.error));

  void success(String message) =>
      _log(message, prefix: _getPrefix(LogType.success));
}
