import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dmcb_logger/net/net_type.dart';
import 'package:flutter_dmcb_logger/util/logger.dart';

class NetEntity extends ChangeNotifier {
  static const all = "All";
  static final List<NetEntity> list = [];
  static final ValueNotifier<int> length = ValueNotifier(0);
  static final Map<String, NetEntity> _map = {};
  static final List<String> types = [all];
  static final ValueNotifier<int> typeLength = ValueNotifier(1);

  NetType type;

  /// 接口名称
  final String api;

  /// 请求url
  String url;

  /// 请求头
  String headers;

  /// 请求方法
  String method;

  /// 请求参数
  String parameters;

  /// 响应体
  final String responseBody;

  /// 时间
  final DateTime startTime;

  /// 请求状态码
  int statusCode;

  /// 是否显示详情
  bool showDetail;

  /// 消耗时间： 毫秒
  int spendTime = 0;

  NetEntity({
    this.type = NetType.http,
    required this.api,
    this.url = '',
    this.headers = '',
    this.method = '',
    this.parameters = '',
    this.responseBody = '',
    required this.startTime,
    this.spendTime = 0,
    this.statusCode = 100,
    this.showDetail = false,
  });

  /// 关键字搜索
  bool contains(String keyword) {
    if (keyword.isEmpty) return true;
    return api.contains(keyword) || responseBody.contains(keyword) || parameters.contains(keyword);
  }

  @override
  String toString() {
    final StringBuffer sb = StringBuffer();
    sb.writeln("[$statusCode] $api");
    sb.writeln("Start: $startTime");
    sb.writeln("Spend: $spendTime ms");
    sb.writeln("Headers: $headers");
    sb.writeln("Request: $responseBody");
    sb.writeln("Response: $parameters");
    return sb.toString();
  }

  static void net({
    NetType type = NetType.http,
    required String api,
    String url = '',
    String method = '',
    String headers = '',
    String parameters = '',
    String responseBody = '',
    int spendTime = 0,
    int statusCode = 100,
    bool showDetail = false,
    bool? hasPrintNet,
    bool? hasWriteNet,
  }) {
    final net = NetEntity(
      type: type,
      api: api,
      url: url,
      headers: headers,
      method: method,
      parameters: parameters,
      responseBody: responseBody,
      spendTime: spendTime,
      statusCode: statusCode,
      showDetail: showDetail,
      startTime: DateTime.now(),
    );

    if (hasWriteNet == true && DLogger.config.hasWriteNet) {
      list.add(net);
      _map[api] = net;
      _clearWhenTooMuch();
      length.value++;
    }

    if (hasPrintNet == true && DLogger.config.hasPrintNet) {
      final StringBuffer sb = StringBuffer();
      sb.writeln('${net.type.printFlag()}[${net.startTime}] [$method]${net.api}');
      sb.write('\nHeader: ${net.headers}');
      sb.write('\nParameters: ${net.parameters}');
      sb.writeln('\nResponseBody: ${net.responseBody}');
      log(sb.toString());
    }
  }

  ///
  static void netRequest() {}

  /// 日志条数判断，超限制清除多余
  static void _clearWhenTooMuch() {
    if (list.length > DLogger.config.maxLimit) {
      list.removeRange(0, (DLogger.config.maxLimit * 0.2).ceil());
    }
  }

  /// 清除接口日志
  static void clear() {
    list.clear();
    _map.clear();
    length.value = 0;
  }
}
