import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dmcb_logger/print/print_type.dart';
import 'package:flutter_dmcb_logger/util/helper.dart';
import 'package:flutter_dmcb_logger/util/logger.dart';

class PrintEntity {
  static final List<PrintEntity> list = [];
  static final ValueNotifier<int> length = ValueNotifier(0);
  static final Map<Object, Object> _map = {};

  /// 清空log日志
  static void clear() {
    list.clear();
    _map.clear();
    length.value = 0;
  }

  /// 日志条数判断，超限制清除多余
  static void _clearWhenTooMuch() {
    if (list.length > DLogger.config.maxLimit) {
      list.removeRange(0, (DLogger.config.maxLimit * 0.2).ceil());
    }
  }

  /// 添加日志
  ///
  /// [type] 类型 info/debug/warn/error
  /// [title] 标题
  /// [content] 内容
  /// [hasPrintLog] 是否控制台打印
  /// [hasWriteLog] 是否写入记录日志
  static void add({
    PrintType type = PrintType.info,
    String title = '',
    required Object content,
    bool? hasPrintLog,
    bool? hasWriteLog,
  }) {
    final logEntity = PrintEntity(
      type: type,
      title: title,
      content: content.toString(),
      startTime: DateTime.now(),
      showDetail: false,
    );

    if (hasWriteLog == true || (hasWriteLog == null && DLogger.config.hasWriteLog)) {
      list.add(logEntity);
      _clearWhenTooMuch();
      length.value++;
    }

    if (hasPrintLog == true || (hasPrintLog == null && DLogger.config.hasPrintLog)) {
      final StringBuffer sb = StringBuffer();
      sb.writeln("${logEntity.type.printFlag()}[${logEntity.startTime.toString()}][${DHelper.getNavigationFile()}]");
      if (logEntity.title.isNotEmpty) sb.writeln(title);
      sb.writeln("\nData:${DHelper.convertJsonString(content)}");
      log(sb.toString());
    }
  }

  /// 类型 info/debug/warn/error
  final PrintType type;

  /// 标题
  final String title;

  /// 内容
  final String content;

  /// 时间
  final DateTime startTime;

  /// 是否显示详情
  final bool showDetail;

  /// 初始化
  const PrintEntity({
    required this.type,
    required this.title,
    required this.content,
    required this.startTime,
    required this.showDetail,
  });

  PrintEntity copyWith({
    PrintType? type,
    String? title,
    String? content,
    DateTime? startTime,
    bool? showDetail,
  }) {
    return PrintEntity(
      type: type ?? this.type,
      title: title ?? this.title,
      content: content ?? this.content,
      startTime: startTime ?? this.startTime,
      showDetail: showDetail ?? this.showDetail,
    );
  }

  /// 关键字搜索
  bool contains(String keyword) {
    if (keyword.isEmpty) return true;
    return content.contains(keyword) || title.contains(keyword);
  }
}
