import 'package:flutter/material.dart';

/// 类型
enum PrintType { debug, info, warn, error }

extension ExPrintType on PrintType {
  /// 日志打印标记
  String printFlag() {
    switch (this) {
      case PrintType.debug:
        return "[DEBUG]";
      case PrintType.info:
        return "[INFO]";
      case PrintType.warn:
        return "[WARN]";
      case PrintType.error:
        return "[ERROR]";
      default:
        return "#";
    }
  }

  String tabFlag() {
    switch (this) {
      case PrintType.debug:
        return "[Debug]";
      case PrintType.info:
        return "[INFO]";
      case PrintType.warn:
        return "[Warn]";
      case PrintType.error:
        return "[Error]";
      default:
        return "##";
    }
  }

  Color color() {
    switch (this) {
      case PrintType.debug:
        return Colors.blue;
      case PrintType.warn:
        return const Color(0xFFF57F17);
      case PrintType.error:
        return Colors.red;
      default:
        return Colors.black38;
    }
  }
}
