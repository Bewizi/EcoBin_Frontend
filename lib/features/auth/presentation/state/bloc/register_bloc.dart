import 'package:ecobin/core/data/error/exception.dart';
import 'package:ecobin/features/auth/domain/auth_repository.dart';
import 'package:ecobin/features/auth/domain/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ========== EVENTS ==========
abstract class RegisterEvent {}

class RegisterRequested extends RegisterEvent {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String password;

  RegisterRequested({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.password,
  });
}

// ========== STATES ==========
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final User user; // ✅ Changed to return User, not just message
  RegisterSuccess(this.user);
}

class RegisterFailure extends RegisterState {
  final String message;
  RegisterFailure(this.message);
}

// ========== BLOC ==========
class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository repository;

  RegisterBloc({required this.repository}) : super(RegisterInitial()) {
    on<RegisterRequested>(_onRegisterRequested);
  }

  Future<void> _onRegisterRequested(
    RegisterRequested event,
    Emitter<RegisterState> emit,
  ) async {
    print('🔵 [RegisterBLoC] Registration started...');
    emit(RegisterLoading());

    try {
      final user = await repository.register(
        fullName: event.fullName,
        email: event.email,
        phoneNumber: event.phoneNumber,
        password: event.password,
      );

      print('🟢 [RegisterBLoC] Registration successful: ${user.fullName}');
      emit(RegisterSuccess(user));
    } on ServerException catch (e) {
      print('🔴 [RegisterBLoC] Server error: ${e.message}');
      emit(RegisterFailure(e.message));
    } on NetworkException catch (e) {
      print('🔴 [RegisterBLoC] Network error: ${e.message}');
      emit(RegisterFailure(e.message));
    } catch (e) {
      print('🔴 [RegisterBLoC] Unexpected error: $e');
      emit(RegisterFailure('Registration failed. Please try again.'));
    }
  }
}
