part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final Profile user;

  const ProfileLoaded(this.user);
}

final class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);
}

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
