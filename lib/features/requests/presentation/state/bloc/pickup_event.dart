part of 'pickup_bloc.dart';

@immutable
sealed class PickupEvent extends Equatable {
  const PickupEvent();

  @override
  List<Object> get props => [];
}

class GetPickupEvent extends PickupEvent {
  const GetPickupEvent();

  @override
  List<Object> get props => [];
}

class CreatePickupEvent extends PickupEvent {
  final String userId;
  final String address;
  final String pickupDate;
  final String pickupTime;
  final String? additionalNote; // This one can stay nullable

  // 2. Create a const constructor requiring these fields
  const CreatePickupEvent({
    required this.userId,
    required this.address,
    required this.pickupDate,
    required this.pickupTime,
    this.additionalNote,
  });

  @override
  List<Object> get props => [
    userId,
    address,
    pickupDate,
    pickupTime,
    additionalNote!,
  ];
}

class GetPickupByIdEvent extends PickupEvent {
  final String id;

  const GetPickupByIdEvent(this.id);
}
