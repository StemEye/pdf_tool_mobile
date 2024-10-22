class Conversion {
  final String filePath;
  final String conversionType;
  final String timestamp;

  Conversion({
    required this.filePath,
    required this.conversionType,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
        'filePath': filePath,
        'conversionType': conversionType,
        'timestamp': timestamp,
      };

  factory Conversion.fromJson(Map<String, dynamic> json) {
    return Conversion(
      filePath: json['filePath'],
      conversionType: json['conversionType'],
      timestamp: json['timestamp'],
    );
  }
}
