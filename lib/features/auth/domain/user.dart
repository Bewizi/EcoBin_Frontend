import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String fullName;
  final String phoneNumber;

  const User({
    required this.id,
    required this.email,
    required this.fullName,
    required this.phoneNumber,
  });

  @override
  List<Object?> get props => [id, fullName, email, phoneNumber];

  factory User.empty() {
    return User(id: "", email: "", fullName: "", phoneNumber: "");
  }

  User copyWith({
    String? id,
    String? fullName,
    String? email,
    String? phoneNumber,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}
