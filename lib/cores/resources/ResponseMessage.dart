/*
通用Response
success => 成功與否
data => 一連串資料 為多個相同資料型態
errorMessage => 不成功時，原因
extraData => json檔中除了以上三者 其他欄位
 */

class ResponseMessage<T> {
  final bool success;
  final List<T> ? data;
  final String ? errorMessage;
  final Map<String, dynamic> ? extraData;

  ResponseMessage({
    required this.success, this.data, this.errorMessage, this.extraData
  });

  factory ResponseMessage.fromJson(Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT){
    return ResponseMessage<T>(
      success: json['success'] as bool, 
      data: json['data'] is List
        ? (json['data'] as List).map<T>((item) => fromJsonT(item as Map<String, dynamic>)).toList()
        : json['data'] is Map<String, dynamic>
            ? [fromJsonT(json['data'] as Map<String, dynamic>)]
            : [],
      errorMessage: json['error'] as String? ?? "",
      extraData: _parseExtraData(json)
    );
  }

  static Map<String, dynamic> _parseExtraData(Map<String, dynamic> json) {
    final extra = <String, dynamic>{};

    json.forEach((key, value) {
      // 排除 success 和 data 欄位
      if (key != 'success' && key != 'data' && key != 'error') {
        extra[key] = value;
      }
    });

    return extra;
  }
}
