import 'package:flutter/foundation.dart';

class AppLogger {
  AppLogger._();

  static void log(dynamic message) {
    if (kDebugMode) {
      debugPrint(message.toString());
    }
  }

  static void error(dynamic message) {
    if (kDebugMode) {
      debugPrint(' ERROR: $message');
    }
  }

  static void success(dynamic message) {
    if (kDebugMode) {
      debugPrint('SUCCESS: $message');
    }
  }
}
