import 'package:ecobin/features/auth/data/models/user_model.dart';

abstract class ProfileRemoteDatasource {
  Future<UserModel> updateProfile({
    String? userType,
    String? pickupLocation,
    String? avatar,
  });
  Future<UserModel> getProfile();
}
