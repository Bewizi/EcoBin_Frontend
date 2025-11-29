import 'package:dio/dio.dart';
import 'package:ecobin/core/data/error/exception.dart';
import 'package:ecobin/core/data/services/api_client.dart';
import 'package:ecobin/features/auth/data/data_sources/auth_remote_datasource.dart';
import 'package:ecobin/features/auth/data/models/user_model.dart';
import 'package:ecobin/features/auth/domain/auth_repository.dart';
import 'package:ecobin/features/auth/domain/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;
  final SharedPreferences sharedPreferences;
  final ApiClient apiClient;

  AuthRepositoryImpl({
    required this.remoteDatasource,
    required this.sharedPreferences,
    required this.apiClient,
  });

  @override
  Future<User> login({required String email, required String password}) async {
    try {
      final response = await remoteDatasource.login(email, password);

      await sharedPreferences.setString('auth_token', response.token);

      apiClient.setToken(response.token);

      return response.user;
    } on ServerException {
      rethrow;
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw ServerException('Login failed: ${e.toString()}');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await remoteDatasource.logout();
    } catch (e) {
      ServerException('Error Logining out ${e.toString()}');
    } finally {
      await sharedPreferences.remove('auth_token');

      apiClient.clearToken();
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    final token = sharedPreferences.getString('auth_token');
    return token != null;
  }

  @override
  Future<User> getCurrentUser() async {
    try {
      final token = sharedPreferences.getString('auth_token');

      if (token == null) {
        throw Exception('No token found');
      }

      apiClient.setToken(token);

      final response = await apiClient.get('/user');
      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      // 🛑 FIX: Only logout if the server says "Unauthenticated" (401)
      if (e.response?.statusCode == 401) {
        await sharedPreferences.remove('auth_token');
        apiClient.clearToken();
        throw ServerException('Session expired');
      }
      // If it's a network error (server down, no wifi),
      // we should probably let them stay (or handle it differently).
      // For now, rethrow so the BLoC knows it failed, but maybe don't delete the token.
      throw NetworkException('Network error: ${e.message}');
    } catch (e) {
      // Only clear token for generic errors if you are strict
      // await sharedPreferences.remove('auth_token');
      rethrow;
    }
  }

  @override
  Future<String?> getToken() async {
    return sharedPreferences.getString('auth_token');
  }

  @override
  Future<User> register({
    String? avatar,
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password,
    String? userType,
    String? pickupLocation,
  }) async {
    try {
      final response = await remoteDatasource.register(
        fullName,
        email,
        phoneNumber,
        password,
      );

      await sharedPreferences.setString('auth_token', response.token);

      apiClient.setToken(response.token);

      return response.user;
    } on ServerException {
      rethrow;
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw ServerException('Registration failed ${e.toString()}');
    }
  }
}
