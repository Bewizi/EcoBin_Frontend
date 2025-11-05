import 'package:ecobin/features/auth/domain/user.dart';

abstract class AuthRepository {
  Future<User> login({required String email, required String password});

  Future<User> register({
    required String email,
    required String password,
    required String fullName,
    required String phoneNumber,
  });

  Future<void> logout();

  Future<bool> isLoggedIn();

  Future<User> getCurrentUser();

  Future<String?> getToken();
}
