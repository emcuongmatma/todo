import 'package:dio/dio.dart';
import 'package:todo/core/constants/app_constants.dart';

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
      return ApiException(AppConstants.TIME_OUT);
    case DioExceptionType.receiveTimeout:
      return ApiException(AppConstants.NOT_RESPONSE);
    case DioExceptionType.badResponse:
      return ApiException(
        e.response?.data['message'],
        statusCode: e.response?.statusCode,
      );
    default:
      return ApiException(AppConstants.NETWORK_ERROR);
  }
}