import 'package:equatable/equatable.dart';

class Pickup extends Equatable {
  final String id;
  final String? userId;
  final String? address;
  final String? pickupDate;
  final String? pickupTime;
  final String? additionalNote;

  const Pickup({
    required this.id,
    required this.userId,
    required this.address,
    required this.pickupDate,
    required this.pickupTime,
    this.additionalNote,
  });

  @override
  List<Object?> get props => [
    id,
    userId,
    address,
    pickupDate,
    pickupTime,
    additionalNote,
  ];

  Pickup copyWith({
    String? id,
    String? userId,
    String? address,
    String? pickupDate,
    String? pickupTime,
    String? additionalNote,
  }) {
    return Pickup(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      address: address ?? this.address,
      pickupDate: pickupDate ?? this.pickupDate,
      pickupTime: pickupTime ?? this.pickupTime,
      additionalNote: additionalNote ?? this.additionalNote,
    );
  }
}
