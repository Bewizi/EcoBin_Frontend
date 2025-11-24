import 'package:ecobin/features/profile/domain/profile.dart';

abstract class ProfileRemoteDatasource {
  Future<Profile> createUserSetup({
    String? fullName,
    String? userType,
    String? pickupLocation,
    String? avatar,
  });
  Future<Profile> getProfile();
}
