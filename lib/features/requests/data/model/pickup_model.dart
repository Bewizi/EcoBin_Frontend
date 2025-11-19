import 'package:ecobin/features/requests/domain/pickup.dart';

class PickupModel extends Pickup {
  const PickupModel({
    required super.id,
    required super.userId,
    required super.address,
    required super.pickupDate,
    required super.pickupTime,
    super.additionalNote,
  });

  factory PickupModel.fromJson(Map<String, dynamic> json) {
    return PickupModel(
      id: json['id'] as String,
      userId: (json['userId'] ?? json['user_id']) as String?,
      address: json['address'] as String?,
      pickupDate: json['pickupDate'] as String?,
      pickupTime: json['pickupTime'] as String?,
      additionalNote: json['additionalNote'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'address': address,
      'pickupDate': pickupDate,
      'pickupTime': pickupTime,
      'additionalNote': additionalNote,
    };
  }

  factory PickupModel.fromEntity(Pickup pickup) {
    return PickupModel(
      id: pickup.id,
      userId: pickup.userId,
      address: pickup.address,
      pickupDate: pickup.pickupDate,
      pickupTime: pickup.pickupTime,
      additionalNote: pickup.additionalNote,
    );
  }
}
