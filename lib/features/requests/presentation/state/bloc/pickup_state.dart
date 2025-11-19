part of 'pickup_bloc.dart';

@immutable
sealed class PickupState {}

final class PickupInitial extends PickupState {}

final class PickupLoading extends PickupState {}

final class PickupLoaded extends PickupState {
  final List<Pickup> pickups;

  PickupLoaded(this.pickups);
}

final class PickupById extends PickupState {
  final Pickup pickup;

  PickupById(this.pickup);
}

final class PickupError extends PickupState {
  final String message;

  PickupError(this.message);
}
