import 'package:ecobin/core/data/error/exception.dart';
import 'package:ecobin/features/auth/domain/user.dart';
import 'package:ecobin/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:ecobin/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDatasource remoteDatasource;

  ProfileRepositoryImpl({required this.remoteDatasource});

  @override
  Future<User> updateUserType(String userType) async {
    try {
      print('🔵 [ProfileRepository] Updating user type: $userType');
      final user = await remoteDatasource.updateProfile(userType: userType);
      print('🟢 [ProfileRepository] User type updated');

      return user;
    } on ServerException {
      rethrow;
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw ServerException('Failed to update user type: $e');
    }
  }

  @override
  Future<User> updatePickupLocation(String location) async {
    try {
      print('🔵 [ProfileRepository] Updating user type: $location');
      final user = await remoteDatasource.updateProfile(
        pickupLocation: location,
      );

      return user;
    } catch (e) {
      throw ServerException('Failed to update pickup location:  $e');
    }
  }

  @override
  Future<User> updateAvatar(String avatar) async {
    try {
      print('🔵 [ProfileRepository] Updating user type: $avatar');
      final user = await remoteDatasource.updateProfile(avatar: avatar);

      return user;
    } catch (e) {
      throw ServerException('Failed to update avatar:  $e');
    }
  }

  @override
  Future<User> getProfile() async {
    try {
      final user = await remoteDatasource.getProfile();

      return user;
    } catch (e) {
      throw ServerException('Failed to get profile:  $e');
    }
  }
}
