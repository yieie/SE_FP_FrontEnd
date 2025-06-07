import 'package:dio/dio.dart';

String handleDioError(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      return '連線逾時，請檢查您的網路連線。';

    case DioExceptionType.sendTimeout:
      return '請求傳送超時，請稍後再試。';

    case DioExceptionType.receiveTimeout:
      return '伺服器回應超時，請稍後再試。';

    case DioExceptionType.badCertificate:
      return '安全憑證錯誤，請確認您連線的是正確的伺服器。';

    case DioExceptionType.badResponse:
      final statusCode = e.response?.statusCode;
      if (statusCode != null) {
        if (statusCode >= 400 && statusCode < 500) {
          return '請求發生錯誤（$statusCode），請確認輸入是否正確。';
        } else if (statusCode >= 500) {
          return '伺服器發生錯誤（$statusCode），請稍後再試。';
        }
      }
      return '伺服器回應錯誤，${e.message}';

    case DioExceptionType.cancel:
      return '請求已被取消。';

    case DioExceptionType.connectionError:
      return '無法連接到伺服器，請確認網路是否正常。';

    case DioExceptionType.unknown:
    default:
      return '發生未知錯誤：${e.message}';
  }
}
