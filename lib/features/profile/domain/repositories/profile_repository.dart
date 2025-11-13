import 'package:ecobin/features/auth/domain/user.dart';

abstract class ProfileRepository {
  Future<User> updateUserType(String userType);
  Future<User> updatePickupLocation(String pickupLocation);
  Future<User> updateAvatar(String avatar);
  Future<User> getProfile();
}
