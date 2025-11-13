import 'package:ecobin/features/auth/domain/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.fullName,
    required super.email,
    required super.phoneNumber,
    super.avatar,
    super.pickupLocation,
    super.userType,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final profile = json['profile'] as Map<String, dynamic>?;
    return UserModel(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      avatar: profile?['avatar'] as String?,
      pickupLocation: profile?['pickupLocation'] as String?,
      userType: profile?['userType'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'avatar': avatar!,
      'userType': userType!,
      'pickupLocation': pickupLocation!,
    };
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      fullName: user.fullName,
      email: user.email,
      phoneNumber: user.phoneNumber,
      avatar: user.avatar!,
      userType: user.userType!,
      pickupLocation: user.pickupLocation!,
    );
  }
}
