import 'package:dio/dio.dart';
import 'package:todo/core/constants/app_constants.dart';
import 'package:todo/core/error/exception.dart';
import 'package:todo/core/error/failure.dart';

class AuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSource(this._dio);

  Future<List<dynamic>> login(String username) async {
    try {
      final response = await _dio.get(
        API.AUTH,
        queryParameters: {"username": username},
      );
      return response.data;
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (e) {
      throw NetworkFailure(e.toString());
    }
  }

  Future<Map<String, dynamic>?> checkIdExists(String id) async {
    try {
      final response = await _dio.get("${API.AUTH}/$id");
      return response.data;
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return null;
      }
      throw mapDioError(e);
    } catch (e) {
      throw NetworkFailure(e.toString());
    }
  }

  Future<Map<String, dynamic>> signUp(String username, String password) async {
    try {
      final response = await _dio.post(API.AUTH, data: {
        'username': username,
        'password': password
      });
      return response.data;
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (e) {
      throw NetworkFailure(e.toString());
    }
  }
}
