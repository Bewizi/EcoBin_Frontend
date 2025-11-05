import 'package:ecobin/features/auth/data/models/login_response_model.dart';
import 'package:ecobin/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDatasource {
  Future<LoginResponseModel> login(String email, String password);
  Future<UserModel> register(
    String fullNme,
    String email,
    String password,
    String phoneNumber,
  );
  Future<void> logout();
}
