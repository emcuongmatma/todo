import 'package:dio/dio.dart';
import 'package:todo/core/constants/app_constants.dart';
import 'package:todo/data/datasources/local/auth_local_data_source.dart';

class DioClient {
  static Dio create(AuthLocalDataSource authLocalDataSource) {
    final dio = Dio(
      BaseOptions(
        baseUrl: API.BASE_URL,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseHeader: false,
        responseBody: true,
      ),
    );

    return dio;
  }
}