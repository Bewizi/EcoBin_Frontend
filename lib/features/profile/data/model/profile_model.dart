import 'package:ecobin/features/profile/domain/profile.dart';

class ProfileModel extends Profile {
  const ProfileModel({
    super.fullName,
    super.avatar,
    super.pickupLocation,
    super.userType,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    final profile = json['profile'] as Map<String, dynamic>?;

    String? avatarUrl;
    if (profile?['avatar'] != null) {
      final avatarPath = profile!['avatar'] as String;

      if (avatarPath.startsWith('http')) {
        avatarUrl = avatarPath;
      } else {
        avatarUrl = 'https://0852a2e04457.ngrok-free.app/storage/$avatarPath';
      }
    }

    return ProfileModel(
      fullName: json['fullName'] as String?,
      avatar: avatarUrl,
      pickupLocation: profile?['pickupLocation'] as String?,
      userType: profile?['userType'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'avatar': avatar,
      'pickupLocation': pickupLocation,
      'userType': userType,
    };
  }

  factory ProfileModel.fromEntity(Profile profile) {
    return ProfileModel(
      fullName: profile.fullName,
      avatar: profile.avatar,
      pickupLocation: profile.pickupLocation,
      userType: profile.userType,
    );
  }
}
