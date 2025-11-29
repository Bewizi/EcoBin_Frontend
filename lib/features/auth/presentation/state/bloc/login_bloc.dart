import 'package:ecobin/core/data/error/exception.dart';
import 'package:ecobin/features/auth/domain/auth_repository.dart';
import 'package:ecobin/features/auth/domain/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AuthEvent {}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  LoginRequested({required this.email, required this.password});
}

class CheckAuthStatus extends AuthEvent {}

// states
abstract class AuthSate {}

class AuthInitial extends AuthSate {}

class AuthLoading extends AuthSate {}

// class AuthAuthenticated extends AuthSate {
//   final User user;
//   AuthAuthenticated(this.user);

// }

// class AuthUnauthenticated extends AuthSate {}

class AuthSuccess extends AuthSate {
  final User user;
  AuthSuccess(this.user);
}

class AuthFailure extends AuthSate {
  final String message;
  AuthFailure(this.message);
}

// bloc
class AuthBloc extends Bloc<AuthEvent, AuthSate> {
  final AuthRepository repository;

  AuthBloc({required this.repository}) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<CheckAuthStatus>(_onCheckAuthStatus);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthSate> emit,
  ) async {
    emit(AuthLoading());

    try {
      final user = await repository.login(
        email: event.email,
        password: event.password,
      );
      emit(AuthSuccess(user));
    } on ServerException catch (e) {
      emit(AuthFailure(e.message));
    } on NetworkException catch (e) {
      emit(AuthFailure(e.message));
    } catch (e) {
      emit(AuthFailure('An unexpected error occurred'));
    }
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatus event,
    Emitter<AuthSate> emit,
  ) async {
    emit(AuthLoading());

    try {
      final user = await repository.getCurrentUser();

      emit(AuthSuccess(user));
    } on ServerException catch (e) {
      emit(AuthFailure(e.message));
    } on NetworkException catch (e) {
      emit(AuthFailure(e.message));
    } catch (e) {
      emit(AuthInitial());
      emit(AuthFailure('An unexpected error occurred'));
    }
  }
}
