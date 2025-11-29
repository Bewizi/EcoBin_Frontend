import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecobin/core/data/error/exception.dart';
import 'package:ecobin/features/auth/domain/user.dart';
import 'package:ecobin/features/profile/domain/profile.dart';
import 'package:ecobin/features/profile/domain/repositories/profile_repository.dart';
import 'package:equatable/equatable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository repository;

  ProfileBloc({required this.repository}) : super(ProfileInitial()) {
    on<GetUserEvent>(_getUser);
    // on<UpdateUserTypeEvent>(_onUpdateUserType);
    // on<UpdatePickupLocationEvent>(_onUpdatePickupLocation);
    on<CreateProfileEvent>(_onCreateProfile);
  }

  Future<void> _getUser(GetUserEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());

    try {
      final user = await repository.getProfile();
      emit(ProfileLoaded(user));
    } on ServerException catch (e) {
      emit(ProfileError(e.message));
    } on NetworkException catch (e) {
      emit(ProfileError(e.message));
    } catch (e) {
      emit(ProfileError('Failed to load user'));
    }
  }

  // Future<void> _onUpdateUserType(
  //   UpdateUserTypeEvent event,
  //   Emitter<ProfileState> emit,
  // ) async {
  //   print('🔵 [ProfileBLoC] Updating user type: ${event.userType}');
  //   emit(ProfileLoading());

  //   try {
  //     final user = await repository.updateUserType(event.userType);
  //     print('🟢 [ProfileBLoC] User type updated successfully');
  //     emit(ProfileUpdateSuccess(user));
  //   } on ServerException catch (e) {
  //     print('🔴 [ProfileBLoC] Server error: ${e.message}');
  //     emit(ProfileUpdateFailure(e.message));
  //   } on NetworkException catch (e) {
  //     print('🔴 [ProfileBLoC] Network error: ${e.message}');
  //     emit(ProfileUpdateFailure(e.message));
  //   } catch (e) {
  //     print('🔴 [ProfileBLoC] Unexpected error: $e');
  //     emit(ProfileUpdateFailure('Failed to update user type'));
  //   }
  // }

  // Future<void> _onUpdatePickupLocation(
  //   UpdatePickupLocationEvent event,
  //   Emitter<ProfileState> emit,
  // ) async {
  //   emit(ProfileLoading());

  //   try {
  //     final user = await repository.updatePickupLocation(event.location);
  //     emit(ProfileUpdateSuccess(user));
  //   } on ServerException catch (e) {
  //     emit(ProfileUpdateFailure(e.message));
  //   } on NetworkException catch (e) {
  //     emit(ProfileUpdateFailure(e.message));
  //   } catch (e) {
  //     emit(ProfileUpdateFailure('Failed to update pickup location'));
  //   }
  // }

  Future<void> _onCreateProfile(
    CreateProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());

    try {
      final profile = await repository.createUserSetup(
        fullName: event.profile.fullName,
        avatar: event.profile.avatar,
        userType: event.profile.userType,
        pickupLocation: event.profile.pickupLocation,
      );
      emit(ProfileLoaded(profile));
    } on ServerException catch (e) {
      emit(ProfileError(e.message));
    } on NetworkException catch (e) {
      emit(ProfileError(e.message));
    } catch (e) {
      emit(ProfileError('Failed to create profile'));
    }
  }
}
