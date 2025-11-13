import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String? avatar;
  final String? userType;
  final String? pickupLocation;

  const User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    this.avatar,
    this.userType,
    this.pickupLocation,
  });

  @override
  List<Object?> get props => [
    id,
    fullName,
    email,
    phoneNumber,
    avatar,
    userType,
    pickupLocation,
  ];

  factory User.empty() {
    return User(id: "", email: "", fullName: "", phoneNumber: "");
  }

  User copyWith({
    String? id,
    String? fullName,
    String? email,
    String? phoneNumber,
    String? avatar,
    String? userType,
    String? pickupLocation,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      avatar: avatar ?? this.avatar,
      userType: userType ?? this.userType,
      pickupLocation: pickupLocation ?? this.pickupLocation,
    );
  }
}
