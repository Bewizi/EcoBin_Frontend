import 'package:ecobin/core/data/error/exception.dart';
import 'package:ecobin/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:ecobin/features/profile/domain/profile.dart';
import 'package:ecobin/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDatasource remoteDatasource;

  ProfileRepositoryImpl({required this.remoteDatasource});

  @override
  Future<Profile> createUserSetup({
    String? userId,
    String? fullName,
    String? avatar,
    String? userType,
    String? pickupLocation,
  }) async {
    try {
      final profile = await remoteDatasource.createUserSetup(
        fullName: fullName,
        userType: userType,
        pickupLocation: pickupLocation,
        avatar: avatar,
      );

      return profile;
    } catch (e) {
      throw ServerException('Failed to create user setup:  $e');
    }
  }

  @override
  Future<Profile> getProfile() async {
    try {
      final user = await remoteDatasource.getProfile();

      return user;
    } catch (e) {
      throw ServerException('Failed to get profile:  $e');
    }
  }
}
