class DConfig {
  /// 日志记录反转
  final bool reverse;

  /// 是否控制台输出网络接口日志
  final bool printNet;

  /// 是否控制台输出日志
  final bool hasPrintLog;

  /// 是否写入日志记录
  final bool hasWriteLog;

  /// 是否写入网络接口日志
  final bool hasWriteNet;

  /// 记录条数限制，默认100条
  final int maxLimit;

  const DConfig({
    required this.reverse,
    required this.printNet,
    required this.hasPrintLog,
    required this.hasWriteLog,
    required this.hasWriteNet,
    required this.maxLimit,
  });

  DConfig copyWith({
    bool? reverse,
    bool? printNet,
    bool? hasPrintLog,
    bool? hasWriteLog,
    bool? hasWriteNet,
    int? maxLimit,
  }) {
    return DConfig(
      reverse: reverse ?? this.reverse,
      printNet: printNet ?? this.printNet,
      hasPrintLog: hasPrintLog ?? this.hasPrintLog,
      hasWriteLog: hasWriteLog ?? this.hasWriteLog,
      hasWriteNet: hasWriteNet ?? this.hasWriteNet,
      maxLimit: maxLimit ?? this.maxLimit,
    );
  }
}
