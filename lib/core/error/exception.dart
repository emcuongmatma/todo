import 'package:dio/dio.dart';
import 'package:todo/i18n/strings.g.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, {this.statusCode});
  @override
  String toString() {
    return message;
  }
}

ApiException mapDioError(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      return ApiException(t.error_time_out);
    case DioExceptionType.receiveTimeout:
      return ApiException(t.error_no_response);
    case DioExceptionType.badResponse:
      return ApiException(
        e.response?.data['message'],
        statusCode: e.response?.statusCode,
      );
    default:
      return ApiException(t.error_network);
  }
}