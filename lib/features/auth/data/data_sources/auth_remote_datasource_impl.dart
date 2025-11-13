import 'package:ecobin/core/data/config/api_config.dart';
import 'package:ecobin/core/data/services/api_client.dart';
import 'package:ecobin/features/auth/data/data_sources/auth_remote_datasource.dart';
import 'package:ecobin/features/auth/data/models/login_response_model.dart';
// import 'package:ecobin/features/auth/data/models/user_model.dart';

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final ApiClient apiClient;

  AuthRemoteDatasourceImpl({required this.apiClient});

  @override
  Future<LoginResponseModel> login(String email, String password) async {
    try {
      final response = await apiClient.post(
        ApiConfig.loginEndpoint,
        data: {'email': email, 'password': password},
      );
      return LoginResponseModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<LoginResponseModel> register(
    String fullName,
    String email,
    String phoneNumber,
    String password,
  ) async {
    try {
      final response = await apiClient.post(
        ApiConfig.registerEndpoint,
        data: {
          'fullName': fullName,
          'email': email,
          'phoneNumber': phoneNumber,
          'password': password,
        },
      );
      return LoginResponseModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await apiClient.post('logout');
    } catch (e) {
      rethrow;
    }
  }
}
