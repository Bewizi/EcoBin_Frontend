part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class UpdateUserTypeEvent extends ProfileEvent {
  final String userType;

  const UpdateUserTypeEvent(this.userType);

  @override
  List<Object> get props => [userType];
}

class UpdatePickupLocationEvent extends ProfileEvent {
  final String location;

  const UpdatePickupLocationEvent(this.location);

  @override
  List<Object> get props => [location];
}
