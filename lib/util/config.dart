/// config
class DConfig {
  /// 日志记录反转
  final bool hasReverse;

  /// 是否控制台输出日志
  final bool hasPrintLog;

  /// 是否写入日志记录
  final bool hasWriteLog;

  /// 是否控制台输出网络接口日志
  final bool hasPrintNet;

  /// 是否写入网络接口日志
  final bool hasWriteNet;

  /// 记录条数限制，默认100条
  final int maxLimit;

  const DConfig({
    required this.hasReverse,
    required this.hasPrintLog,
    required this.hasWriteLog,
    required this.hasPrintNet,
    required this.hasWriteNet,
    required this.maxLimit,
  });

  DConfig copyWith({
    bool? hasReverse,
    bool? hasPrintLog,
    bool? hasWriteLog,
    bool? hasPrintNet,
    bool? hasWriteNet,
    int? maxLimit,
  }) {
    return DConfig(
      hasReverse: hasReverse ?? this.hasReverse,
      hasPrintLog: hasPrintLog ?? this.hasPrintLog,
      hasWriteLog: hasWriteLog ?? this.hasWriteLog,
      hasPrintNet: hasPrintNet ?? this.hasPrintNet,
      hasWriteNet: hasWriteNet ?? this.hasWriteNet,
      maxLimit: maxLimit ?? this.maxLimit,
    );
  }
}
