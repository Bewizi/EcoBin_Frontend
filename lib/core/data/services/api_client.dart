import 'package:dio/dio.dart';
import 'package:ecobin/core/data/config/api_config.dart';
import 'package:ecobin/core/data/error/exception.dart';
import 'package:ecobin/core/data/services/api_interceptor.dart';

class ApiClient {
  late final Dio _dio;

  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: ApiConfig.headers,
      ),
    );

    _dio.interceptors.add(ApiInterceptor());

    _dio.interceptors.add(
      LogInterceptor(error: true, requestBody: true, responseBody: true),
    );
  }

  // GET REQUEST
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // POST REQUEST
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.post(
        path,
        data: data,
        options: options,
        queryParameters: queryParameters,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // PUT REQUEST
  Future<Response> put(String path, {dynamic data, Options? options}) async {
    try {
      return await _dio.put(path, data: data, options: options);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete REQUEST
  Future<Response> delete(String path, {dynamic data, Options? options}) async {
    try {
      return await _dio.delete(path, data: data, options: options);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  void setToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  void clearToken() {
    _dio.options.headers.remove('Authorization');
  }

  Exception _handleError(DioException error) {
    // You can customize error handling based on status codes or error types
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkException('Connection timeout');
      case DioExceptionType.badResponse:
        return ServerException(
          error.response?.data['message'] ?? 'Server error',
          statusCode: error.response?.statusCode,
        );
      case DioExceptionType.cancel:
        return NetworkException('Request was cancelled');
      default:
        return Exception('Unexpected error occurred');
    }
  }
}
