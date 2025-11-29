import 'package:ecobin/core/data/services/api_client.dart';
import 'package:ecobin/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:ecobin/features/profile/data/model/profile_model.dart';

class ProfileRemoteDatasourceImpl implements ProfileRemoteDatasource {
  final ApiClient apiClient;

  ProfileRemoteDatasourceImpl({required this.apiClient});

  @override
  Future<ProfileModel> createUserSetup({
    String? avatar,
    String? fullName,
    String? userType,
    String? pickupLocation,
  }) async {
    try {
      print('🔵 [ProfileDataSource] Updating profile...');

      final Map<String, dynamic> data = {};

      if (avatar != null) data['avatar'] = avatar;
      if (userType != null) data['userType'] = userType;
      if (pickupLocation != null) data['pickupLocation'] = pickupLocation;
      if (fullName != null) data['fullName'] = fullName;

      print('🟢 [ProfileDataSource] Profile updated successfully');

      final response = await apiClient.post('profile', data: data);

      return ProfileModel.fromJson(response.data['user']);
    } catch (e) {
      print('🔴 [ProfileDataSource] Update failed: $e');
      rethrow;
    }
  }

  @override
  Future<ProfileModel> getProfile() async {
    try {
      final response = await apiClient.get('profile');
      return ProfileModel.fromJson(response.data['user']);
    } catch (e) {
      rethrow;
    }
  }
}
