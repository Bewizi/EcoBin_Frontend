import 'package:ecobin/core/data/services/api_client.dart';
import 'package:ecobin/features/auth/data/models/user_model.dart';
import 'package:ecobin/features/profile/data/datasources/profile_remote_datasource.dart';

class ProfileRemoteDatasourceImpl implements ProfileRemoteDatasource {
  final ApiClient apiClient;

  ProfileRemoteDatasourceImpl({required this.apiClient});

  @override
  Future<UserModel> updateProfile({
    String? userType,
    String? pickupLocation,
    String? avatar,
  }) async {
    try {
      print('🔵 [ProfileDataSource] Updating profile...');

      final Map<String, dynamic> data = {};

      if (userType != null) data['userType'] = userType;
      if (pickupLocation != null) data['pickupLocation'] = pickupLocation;
      if (avatar != null) data['avatar'] = avatar;

      print('🟢 [ProfileDataSource] Profile updated successfully');

      final response = await apiClient.put('/profile', data: data);

      return UserModel.fromJson(response.data['user']);
    } catch (e) {
      print('🔴 [ProfileDataSource] Update failed: $e');
      rethrow;
    }
  }

  @override
  Future<UserModel> getProfile() async {
    try {
      final response = await apiClient.get('/profile');
      return UserModel.fromJson(response.data['user']);
    } catch (e) {
      rethrow;
    }
  }
}
