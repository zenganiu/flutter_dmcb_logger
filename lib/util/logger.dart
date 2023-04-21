import 'package:flutter_dmcb_logger/net/net_entity.dart';
import 'package:flutter_dmcb_logger/net/net_type.dart';
import 'package:flutter_dmcb_logger/print/print_entity.dart';
import 'package:flutter_dmcb_logger/print/print_type.dart';
import 'package:flutter_dmcb_logger/util/config.dart';
import 'package:flutter_dmcb_logger/util/helper.dart';

class DLogger {
  const DLogger._();

  static bool enabled = true;
  static DConfig config = const DConfig(
    reverse: true,
    printNet: true,
    hasPrintLog: true,
    hasWriteLog: true,
    hasWriteNet: true,
    maxLimit: 100,
  );

  /// 清空所有日志
  static void clear() {
    _Logger.clear();
  }

  /// info信息
  ///
  /// [message] 内容
  /// [title] 标题
  /// [hasPrintLog] 是否打印日志
  /// [hasWriteLog] 是否写入日志
  static void info(Object message, {String title = '', bool hasPrintLog = true, hasWriteLog = true}) {
    _Logger.info(message, title: title, hasPrintLog: hasPrintLog, hasWriteLog: hasWriteLog);
  }

  /// 调试信息
  ///
  /// [message] 内容
  /// [title] 标题
  /// [hasPrintLog] 是否打印日志
  /// [hasWriteLog] 是否写入日志
  static void debug(Object message, {String title = '', bool hasPrintLog = true, hasWriteLog = true}) {
    _Logger.debug(message, title: title, hasPrintLog: hasPrintLog, hasWriteLog: hasWriteLog);
  }

  /// 警告信息
  ///
  /// [message] 内容
  /// [title] 标题
  /// [hasPrintLog] 是否打印日志
  /// [hasWriteLog] 是否写入日志
  static void warn(Object message, {String title = '', bool hasPrintLog = true, hasWriteLog = true}) {
    _Logger.warn(message, title: title, hasPrintLog: hasPrintLog, hasWriteLog: hasWriteLog);
  }

  /// 错误信息
  ///
  /// [message] 内容
  /// [title] 标题
  /// [hasPrintLog] 是否打印日志
  /// [hasWriteLog] 是否写入日志
  static void error(Object message, {String title = '', bool hasPrintLog = true, hasWriteLog = true}) {
    _Logger.error(message, title: title, hasPrintLog: hasPrintLog, hasWriteLog: hasWriteLog);
  }

  /// 接口日志
  ///
  /// [api] api名称
  /// [url] 请求路径
  /// [method] 请求方法
  /// [headers] 请求头
  /// [parameters] 请求参数
  /// [responseBody] 响应数据
  /// [spendTime] 花费时间
  /// [statusCode] 请求状态码
  /// [showDetail] 是否展开
  /// [printLog] 是否打印日志
  /// [writeLog] 是否写入日志
  static void net({
    required String api,
    String url = '',
    String method = '',
    Object headers = '',
    Object parameters = '',
    Object responseBody = '',
    int spendTime = 0,
    int statusCode = 100,
    bool showDetail = false,
    bool? printLog,
    bool? writeLog,
  }) {
    _Logger.net(
      api: api,
      url: url,
      method: method,
      headers: headers,
      parameters: parameters,
      responseBody: responseBody,
      spendTime: spendTime,
      statusCode: statusCode,
      showDetail: showDetail,
      printLog: printLog,
      writeLog: writeLog,
    );
  }
}

class _Logger {
  const _Logger._();

  /// 清空所有日志
  static void clear() {
    PrintEntity.clear();
    NetEntity.clear();
  }

  static void debug(Object message, {String title = '', bool hasPrintLog = true, hasWriteLog = true}) {
    if (DLogger.enabled) {
      PrintEntity.add(
        type: PrintType.debug,
        content: message,
        title: title,
        hasPrintLog: hasPrintLog,
        hasWriteLog: hasWriteLog,
      );
    }
  }

  static void info(Object message, {String title = '', bool hasPrintLog = true, hasWriteLog = true}) {
    if (DLogger.enabled) {
      PrintEntity.add(
        type: PrintType.info,
        content: message,
        title: title,
        hasPrintLog: hasPrintLog,
        hasWriteLog: hasWriteLog,
      );
    }
  }

  static void warn(Object message, {String title = '', bool hasPrintLog = true, hasWriteLog = true}) {
    if (DLogger.enabled) {
      PrintEntity.add(
        type: PrintType.warn,
        content: message,
        title: title,
        hasPrintLog: hasPrintLog,
        hasWriteLog: hasWriteLog,
      );
    }
  }

  static void error(Object message, {String title = '', bool hasPrintLog = true, hasWriteLog = true}) {
    if (DLogger.enabled) {
      PrintEntity.add(
        type: PrintType.error,
        content: message,
        title: title,
        hasPrintLog: hasPrintLog,
        hasWriteLog: hasWriteLog,
      );
    }
  }

  static void net({
    required String api,
    String url = '',
    String method = '',
    Object headers = '',
    Object parameters = '',
    Object responseBody = '',
    int spendTime = 0,
    int statusCode = 100,
    bool showDetail = false,
    bool? printLog,
    bool? writeLog,
  }) {
    if (DLogger.enabled) {
      NetEntity.net(
        type: NetType.http,
        api: api,
        url: url,
        method: method,
        headers: DHelper.convertJsonString(headers),
        parameters: DHelper.convertJsonString(parameters),
        responseBody: DHelper.convertJsonString(responseBody),
        spendTime: spendTime,
        statusCode: statusCode,
        showDetail: showDetail,
        printLog: printLog,
        writeLog: writeLog,
      );
    }
  }
}
