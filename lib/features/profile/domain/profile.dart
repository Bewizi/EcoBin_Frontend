import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  final String? fullName;
  final String? avatar;
  final String? pickupLocation;
  final String? userType;

  const Profile({
    this.fullName,
    this.avatar,
    this.pickupLocation,
    required this.userType,
  });

  @override
  List<Object?> get props => [fullName, avatar, pickupLocation, userType];

  Profile copyWith({
    String? fullName,
    String? avatar,
    String? pickupLocation,
    String? userType,
  }) {
    return Profile(
      fullName: fullName ?? this.fullName,
      avatar: avatar ?? this.avatar,
      pickupLocation: pickupLocation ?? this.pickupLocation,
      userType: userType ?? this.userType,
    );
  }
}
