import 'dart:developer' as dev;

class Log {
  Log._();

  static const String _closeColor = "\x1B[0m";

  static const Map<LogColor, String> _colors = {
    LogColor.black: "\x1B[30m",
    LogColor.red: "\x1B[31m",
    LogColor.green: "\x1B[32m",
    LogColor.yellow: "\x1B[33m",
    LogColor.blue: "\x1B[34m",
    LogColor.magenta: "\x1B[35m",
    LogColor.cyan: "\x1B[36m",
    LogColor.white: "\x1B[37m",
    LogColor.reset: "\x1B[0m",
    LogColor.none: "",
  };

  static void log(
    String data, {
    LogColor color = LogColor.green,
    String? name,
  }) {
    dev.log("${_colors[color]}$data$_closeColor", name: name ?? "DEBUG LOG: ");
  }
}

enum LogColor {
  red,
  black,
  green,
  yellow,
  blue,
  magenta,
  cyan,
  white,
  reset,
  none,
}
