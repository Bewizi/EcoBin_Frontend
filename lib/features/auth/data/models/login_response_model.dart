import 'package:ecobin/features/auth/data/models/user_model.dart';

class LoginResponseModel {
  final UserModel user;
  final String token;

  LoginResponseModel({required this.user, required this.token});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    final userJson = json['user'];

    if (userJson is! Map<String, dynamic>) {
      throw const FormatException(
        'Invalid or missing "user" data in API response.',
      );
    }

    return LoginResponseModel(
      user: UserModel.fromJson(json['user']),
      token: json['token'] as String,
    );
  }
}
