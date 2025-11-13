part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileLodaing extends ProfileState {}

class ProfileUpdateSuccess extends ProfileState {
  final User user;

  const ProfileUpdateSuccess(this.user);

  @override
  List<Object> get props => [user];
}

final class ProfileUpdateFailure extends ProfileState {
  final String message;
  const ProfileUpdateFailure(this.message);

  @override
  List<Object> get props => [message];
}
