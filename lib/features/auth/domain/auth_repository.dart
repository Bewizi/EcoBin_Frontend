import 'package:ecobin/features/auth/domain/user.dart';

abstract class AuthRepository {
  Future<User> login({required String email, required String password});

  Future<User> register({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password,
    String avatar,
    String userType,
    String pickupLocation,
  });

  Future<void> logout();

  Future<bool> isLoggedIn();

  Future<User> getCurrentUser();

  Future<String?> getToken();
}
