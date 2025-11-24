import 'package:ecobin/features/profile/domain/profile.dart';

abstract class ProfileRepository {
  Future<Profile> createUserSetup({
    String? userId,
    String? fullName,
    String? avatar,
    String? userType,
    String? pickupLocation,
  });

  Future<Profile> getProfile();
}
